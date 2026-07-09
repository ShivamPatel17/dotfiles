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

	local parts = {}
	local order = { "busy", "idle" }
	local shown = {}
	for _, s in ipairs(order) do
		if counts[s] then
			table.insert(parts, counts[s] .. string.upper(s:sub(1, 1)))
			shown[s] = true
		end
	end
	for s, c in pairs(counts) do
		if not shown[s] then
			table.insert(parts, c .. string.upper(s:sub(1, 1)))
		end
	end

	return table.concat(parts, " ")
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

	local choices = {}
	local ws_names = {}
	for ws, _ in pairs(by_workspace) do
		table.insert(ws_names, ws)
	end
	table.sort(ws_names)

	for _, ws in ipairs(ws_names) do
		local ws_agents = by_workspace[ws]
		for _, agent in ipairs(ws_agents) do
			local status_icon = agent.status == "busy" and "●" or "○"
			local name = agent.name or "unnamed"
			local label = string.format("%s %s  [%s]  %s", status_icon, name, agent.status, ws)
			table.insert(choices, {
				id = shorten_home(agent.cwd or ""),
				label = label,
			})
		end
	end

	return choices
end

return M
