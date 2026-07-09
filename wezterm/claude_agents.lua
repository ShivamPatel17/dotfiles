local wezterm = require("wezterm")

local M = {}

local THROTTLE_SECONDS = 5
local HOME = os.getenv("HOME") or ""
local EXCLUDED_PATHS = {
	HOME .. "/.local/share/captain/",
}

local function shorten_home(path)
	if path:sub(1, #HOME) == HOME then
		return "~" .. path:sub(#HOME + 1)
	end
	return path
end

local function is_excluded(cwd)
	for _, prefix in ipairs(EXCLUDED_PATHS) do
		if cwd:sub(1, #prefix) == prefix then
			return true
		end
	end
	return false
end

function M.poll()
	local now = os.time()
	if not wezterm.GLOBAL.claude_agents_cache then
		wezterm.GLOBAL.claude_agents_cache = {}
	end
	local cache = wezterm.GLOBAL.claude_agents_cache

	if cache.last_update and (now - cache.last_update) < THROTTLE_SECONDS then
		return cache.agents or {}
	end

	local home = os.getenv("HOME") or ""
	local success, stdout = wezterm.run_child_process({
		home .. "/.local/share/mise/shims/claude",
		"agents",
		"--json",
	})

	if not success or not stdout or stdout == "" then
		wezterm.GLOBAL.claude_agents_cache = { last_update = now, agents = cache.agents or {} }
		return cache.agents or {}
	end

	local ok, parsed = pcall(wezterm.json_parse, stdout)
	if not ok or type(parsed) ~= "table" then
		wezterm.GLOBAL.claude_agents_cache = { last_update = now, agents = cache.agents or {} }
		return cache.agents or {}
	end

	wezterm.GLOBAL.claude_agents_cache = { last_update = now, agents = parsed }
	return parsed
end

local STATUS_COLORS = {
	busy = "#FFB86C",
	waiting = "#FF5555",
	idle = "#6272A4",
}
local DEFAULT_STATUS_COLOR = "#F1FA8C"

function M.summary()
	local agents = M.poll()
	if #agents == 0 then
		return ""
	end

	local counts = {}
	for _, agent in ipairs(agents) do
		if agent.cwd and not is_excluded(agent.cwd) then
			local status = agent.status or "unknown"
			counts[status] = (counts[status] or 0) + 1
		end
	end

	local order = { "busy", "waiting", "idle" }
	local parts = {}
	for i, s in ipairs(order) do
		local count = counts[s] or 0
		local text = string.format("%2d%s", count, string.upper(s:sub(1, 1)))
		table.insert(parts, { Foreground = { Color = STATUS_COLORS[s] or DEFAULT_STATUS_COLOR } })
		table.insert(parts, { Text = text })
		if i < #order then
			table.insert(parts, { Text = " " })
		end
	end
	table.insert(parts, { Text = " " })

	return wezterm.format(parts)
end

function M.get_choices()
	local agents = M.poll()
	local by_workspace = {}

	for _, agent in ipairs(agents) do
		if not agent.cwd or is_excluded(agent.cwd) then
			goto continue
		end
		local workspace = agent.cwd:match("[^/]+$") or "unknown"
		if not by_workspace[workspace] then
			by_workspace[workspace] = {}
		end
		table.insert(by_workspace[workspace], agent)
		::continue::
	end

	local ws_names = {}
	for ws, _ in pairs(by_workspace) do
		table.insert(ws_names, ws)
	end
	table.sort(ws_names)

	local WORKSPACE_COLOR = "#BD93F9"
	local NAME_COLOR = "#F8F8F2"

	-- gather rows first so status/workspace columns can be aligned
	local rows = {}
	local status_width = 0
	local workspace_width = 0
	for _, ws in ipairs(ws_names) do
		for _, agent in ipairs(by_workspace[ws]) do
			local status = agent.status or "unknown"
			local status_icon = status == "busy" and "●" or status == "waiting" and "◉" or "○"
			local status_text = string.format("%s [%s]", status_icon, status)
			status_width = math.max(status_width, #status_text)
			workspace_width = math.max(workspace_width, #ws)
			table.insert(rows, {
				agent = agent,
				ws = ws,
				status = status,
				status_text = status_text,
			})
		end
	end

	local visits = wezterm.GLOBAL.claude_agent_visits or {}
	table.sort(rows, function(a, b)
		local a_visit = visits[tostring(a.agent.pid)] or 0
		local b_visit = visits[tostring(b.agent.pid)] or 0
		if a_visit ~= b_visit then
			return a_visit > b_visit
		end
		return a.ws < b.ws
	end)

	local choices = {}
	for _, row in ipairs(rows) do
		local name = row.agent.name or "unnamed"
		local status_color = STATUS_COLORS[row.status] or DEFAULT_STATUS_COLOR
		local label = wezterm.format({
			{ Foreground = { Color = status_color } },
			{ Text = row.status_text .. string.rep(" ", status_width - #row.status_text) .. "  " },
			{ Foreground = { Color = WORKSPACE_COLOR } },
			{ Text = row.ws .. string.rep(" ", workspace_width - #row.ws) .. "  " },
			{ Foreground = { Color = NAME_COLOR } },
			{ Text = name },
		})
		table.insert(choices, {
			id = tostring(row.agent.pid),
			label = label,
		})
	end

	return choices
end

function M.record_visit(pid)
	if not wezterm.GLOBAL.claude_agent_visits then
		wezterm.GLOBAL.claude_agent_visits = {}
	end
	wezterm.GLOBAL.claude_agent_visits[tostring(pid)] = os.time()
end

function M.find_pane(pid)
	local success, tty_out = wezterm.run_child_process({ "ps", "-o", "tty=", "-p", tostring(pid) })
	if not success or not tty_out or tty_out:match("^%s*$") then
		return nil
	end

	local tty = "/dev/" .. tty_out:gsub("%s+", "")

	local ok_list, list_json = wezterm.run_child_process({ "wezterm", "cli", "list", "--format", "json" })
	if not ok_list or not list_json then
		return nil
	end

	local ok_parse, panes = pcall(wezterm.json_parse, list_json)
	if not ok_parse or type(panes) ~= "table" then
		return nil
	end

	for _, p in ipairs(panes) do
		if p.tty_name == tty then
			return { pane_id = p.pane_id, workspace = p.workspace }
		end
	end

	return nil
end

return M
