local colors = require("colors")
local settings = require("settings")

local front_app = sbar.add("item", "front_app", {
	display = "active",
	icon = { drawing = false },
	label = {
		font = {
			family = "JetBrainsMono Nerd Font",
			style = settings.font.style_map["Black"],
			size = settings.font.size_map["large"],
		},
		padding_right = 0,
	},
	background = {
		padding_right = -16,
	},
	color = colors.red,
	updates = true,
})

front_app:subscribe("front_app_switched", function(env)
	front_app:set({ label = { string = env.INFO } })
end)
