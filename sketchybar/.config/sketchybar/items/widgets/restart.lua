local icons = require("icons")
local colors = require("colors")
local settings = require("settings")

local restart = sbar.add("item", "widgets.restart", {
	position = "right",
	icon = {
		string = icons.restart,
		padding_left = 0,
		font = {
			style = settings.font.style_map["Black"],
			size = settings.font.size_map["xlarge"],
		},
	},
	label = { drawing = false },
})

sbar.add("bracket", "widgets.restart.bracket", { restart.name }, {
	background = { color = colors.bg1 },
})

sbar.add("item", "widgets.restart.padding", {
	position = "right",
	width = settings.group_paddings,
})

restart:subscribe("mouse.clicked", function(env)
	sbar.exec("sketchybar --reload")
end)
