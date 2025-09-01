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
local workspace_switcher = wezterm.plugin.require("https://github.com/MLFlexer/smart_workspace_switcher.wezterm") -- need to comment out the [url] overwrite in your global .gitconfig (which lives in this repo) when first setting this up on a new machine. See https://github.com/wezterm/wezterm/issues/4490
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
	{
		key = "m",
		mods = "LEADER",
		action = wezterm.action.TogglePaneZoomState,
	},
	-- resize wezterm panes
	{ key = "LeftArrow", mods = "ALT|SHIFT", action = act.AdjustPaneSize({ "Left", 4 }) },
	{ key = "RightArrow", mods = "ALT|SHIFT", action = act.AdjustPaneSize({ "Right", 4 }) },
	{ key = "UpArrow", mods = "ALT|SHIFT", action = act.AdjustPaneSize({ "Up", 4 }) },
	{ key = "DownArrow", mods = "ALT|SHIFT", action = act.AdjustPaneSize({ "Down", 4 }) },

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

workspace_switcher.workspace_formatter = function(label)
	return wezterm.format({
		{ Foreground = { Color = "#50FA7B" } },
		{ Background = { Color = "#282a36" } },
		{ Text = "󱂬: " .. label },
	})
end

workspace_switcher.zoxide_path = "/opt/homebrew/bin/zoxide"
workspace_switcher.apply_to_config(config)

-- tabline
local tabline = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez") -- need to comment out the [url] overwrite in your global .gitconfig (which lives in this repo) when first setting this up on a new machine. See https://github.com/wezterm/wezterm/issues/4490
tabline.setup({
	options = {
		icons_enabled = true,
		theme = "Dracula",
		tabs_enabled = true,
		theme_overrides = {},
		section_separators = "",
		component_separators = "",
		tab_separators = "",
	},
	sections = {
		tabline_a = { "workspace" },
		tabline_b = { "" },
		tabline_c = { "" },
		tab_active = {
			"[",
			"index",
			"]",
			{ "zoomed", padding = 0 },
		},
		tab_inactive = { "index", { "process", padding = { left = 0, right = 1 } } },
		tabline_x = { "" },
		tabline_y = { "" },
		tabline_z = { "" },
	},
	extensions = {},
})
-- basic configs

config.window_decorations = "RESIZE"
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }
config.use_fancy_tab_bar = false

config.color_scheme = "Dracula (Official)"
config.colors = {
	background = "#22272F", -- Replace with your desired hex code or color name
}
config.inactive_pane_hsb = {
	-- Reduce saturation to make the inactive pane more "washed out"
	saturation = 0.5,
	-- Reduce brightness to make the inactive pane dimmer
	brightness = 0.5,
	-- Change the hue (color shift). You can experiment with this.
	hue = 1.0,
}
config.font_size = 14
config.bold_brightens_ansi_colors = true
config.underline_thickness = 1

config.scrollback_lines = 3500
config.use_fancy_tab_bar = false

-- Finally, return the configuration to wezterm:
return config
