-- Pull in the wezterm API
local wezterm = require("wezterm")

local config = wezterm.config_builder()
local act = wezterm.action

config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }

config.window_decorations = "RESIZE"
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }
config.use_fancy_tab_bar = false

config.keys = {
	{ key = "{", mods = "SHIFT|ALT", action = act.MoveTabRelative(-1) },
	{ key = "}", mods = "SHIFT|ALT", action = act.MoveTabRelative(1) },
}

config.color_scheme = "Dracula (Official)"
config.font_size = 14
config.bold_brightens_ansi_colors = true
config.underline_thickness = 1

-- Workspace Switcher config
local workspace_switcher = wezterm.plugin.require("https://github.com/MLFlexer/smart_workspace_switcher.wezterm") -- need to remove the url overwrite in your global gitignore when first setting this up on a new machine. See https://github.com/wezterm/wezterm/issues/4490
config.keys = {
	-- ...
	-- your other keybindings
	{
		key = "j",
		mods = "LEADER",
		action = workspace_switcher.switch_workspace(),
	},
	{
		key = "L",
		mods = "LEADER",
		action = workspace_switcher.switch_to_prev_workspace(),
	},
}
wezterm.on("smart_workspace_switcher.workspace_switcher.chosen", function(window, workspace)
	local gui_win = window:gui_window()
	local base_path = string.gsub(workspace, "(.*[/\\])(.*)", "%2")
	gui_win:set_right_status(wezterm.format({
		{ Foreground = { Color = "purple" } },
		{ Text = base_path .. "  " },
	}))
end)

wezterm.on("smart_workspace_switcher.workspace_switcher.created", function(window, workspace)
	local gui_win = window:gui_window()
	local base_path = string.gsub(workspace, "(.*[/\\])(.*)", "%2")
	gui_win:set_right_status(wezterm.format({
		{ Foreground = { Color = "purple" } },
		{ Text = base_path .. "  " },
	}))
end)

workspace_switcher.zoxide_path = "/opt/homebrew/bin/zoxide"
workspace_switcher.apply_to_config(config)
-- Finally, return the configuration to wezterm:
return config
