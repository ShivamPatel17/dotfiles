-- Pull in the wezterm API
local wezterm = require("wezterm")

local config = wezterm.config_builder()
local act = wezterm.action

config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }

-- used for Wezterm Pane switching
local function is_vim(pane)
	return pane:get_user_vars().IS_NVIM == "true"
end

local direction_keys = {
	h = "Left",
	j = "Down",
	k = "Up",
	l = "Right",
}

local function move_pane(key)
	return {
		key = key,
		mods = "CTRL",
		action = wezterm.action_callback(function(win, pane)
			if is_vim(pane) then
				-- pass the keys through to vim/nvim
				win:perform_action({
					SendKey = { key = key, mods = "CTRL" },
				}, pane)
			else
				win:perform_action({ ActivatePaneDirection = direction_keys[key] }, pane)
			end
		end),
	}
end

-- Workspace Switcher config
local workspace_switcher = wezterm.plugin.require("https://github.com/MLFlexer/smart_workspace_switcher.wezterm") -- need to remove the url overwrite in your global gitignore when first setting this up on a new machine. See https://github.com/wezterm/wezterm/issues/4490
config.keys = {
	{ key = "{", mods = "SHIFT|ALT", action = act.MoveTabRelative(-1) },
	{ key = "}", mods = "SHIFT|ALT", action = act.MoveTabRelative(1) },
	{
		key = "j",
		mods = "LEADER",
		action = workspace_switcher.switch_workspace(),
	},
	{
		key = "l",
		mods = "LEADER",
		action = workspace_switcher.switch_to_prev_workspace(),
	},
	{
		key = "-",
		mods = "LEADER",
		action = wezterm.action.SplitPane({
			direction = "Down",
		}),
	},
	{
		key = "x",
		mods = "CTRL",
		action = wezterm.action.CloseCurrentPane({ confirm = true }),
	},
	{
		key = "|",
		mods = "LEADER",
		action = wezterm.action.SplitPane({
			direction = "Right",
		}),
	},
	-- resize wezterm panes
	{ key = "LeftArrow", mods = "ALT|SHIFT", action = act.AdjustPaneSize({ "Left", 1 }) },
	{ key = "RightArrow", mods = "ALT|SHIFT", action = act.AdjustPaneSize({ "Right", 1 }) },
	{ key = "UpArrow", mods = "ALT|SHIFT", action = act.AdjustPaneSize({ "Up", 1 }) },
	{ key = "DownArrow", mods = "ALT|SHIFT", action = act.AdjustPaneSize({ "Down", 1 }) },

	-- move between split panes
	move_pane("h"),
	move_pane("j"),
	move_pane("k"),
	move_pane("l"),
}

wezterm.on("smart_workspace_switcher.workspace_switcher.chosen", function(window, workspace)
	local gui_win = window:gui_window()
	local base_path = string.gsub(workspace, "(.*[/\\])(.*)", "%2")
	gui_win:set_right_status(wezterm.format({
		{ Foreground = { Color = "white" } },
		{ Text = base_path .. "  " },
	}))
end)

wezterm.on("smart_workspace_switcher.workspace_switcher.created", function(window, workspace)
	local gui_win = window:gui_window()
	local base_path = string.gsub(workspace, "(.*[/\\])(.*)", "%2")
	gui_win:set_right_status(wezterm.format({
		{ Foreground = { Color = "white" } },
		{ Text = base_path .. "  " },
	}))
end)

workspace_switcher.zoxide_path = "/opt/homebrew/bin/zoxide"
workspace_switcher.apply_to_config(config)

-- basic configs

config.window_decorations = "RESIZE"
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }
config.use_fancy_tab_bar = false

config.color_scheme = "Dracula (Official)"
config.font_size = 14
config.bold_brightens_ansi_colors = true
config.underline_thickness = 1

-- Finally, return the configuration to wezterm:
return config
