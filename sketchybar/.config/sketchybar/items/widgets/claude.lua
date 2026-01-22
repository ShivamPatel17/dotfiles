local icons = require("icons")
local colors = require("colors")
local settings = require("settings")

-- Create the Claude status indicator
local claude = sbar.add("item", "widgets.claude", {
	position = "left",
	icon = {
		string = "󰚩",  -- Brain/AI icon
		font = {
			family = settings.font.numbers,
			style = settings.font.style_map["Black"],
			size = settings.font.size_map["large"],
		},
		color = colors.orange,
		padding_left = 8,
	},
	label = {
		string = "Waiting",
		font = {
			family = settings.font.text,
			style = settings.font.style_map["Bold"],
			size = settings.font.size_map["small"],
		},
		padding_right = 8,
	},
	background = {
		color = colors.bg1,
		border_color = colors.orange,
		border_width = 1,
	},
	padding_left = 4,
	padding_right = 4,
	drawing = false,  -- Hidden by default
	update_freq = 2,  -- Check every 2 seconds
	script = "$CONFIG_DIR/plugins/claude_status.sh",
})

-- Update function
claude:subscribe("routine", function()
	sbar.exec("$CONFIG_DIR/plugins/claude_status.sh")
end)

-- Click handler - focus terminal or show notification
claude:subscribe("mouse.clicked", function()
	-- Try to focus the terminal running Claude Code
	-- Adjust this based on your terminal (iTerm, kitty, etc.)
	sbar.exec("open -a 'iTerm'")

	-- Optionally show a notification
	sbar.exec("osascript -e 'display notification \"Claude Code is waiting for input\" with title \"Claude Code\"'")
end)

-- Background bracket
sbar.add("bracket", "widgets.claude.bracket", { claude.name }, {
	background = { color = colors.bg1 },
})

-- Padding
sbar.add("item", "widgets.claude.padding", {
	position = "left",
	width = settings.group_paddings,
})
