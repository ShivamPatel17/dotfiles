local settings = require("settings")
local colors = require("colors")

-- Padding item required because of bracket
sbar.add("item", { position = "right", width = settings.group_paddings })

local cal_up = sbar.add("item", {
	position = "right",
	padding_left = -5,
	width = 0,
	label = {
		color = colors.white,
		font = {
			family = settings.font.numbers,
			style = settings.font.style_map["Black"],
			size = settings.font.size_map["small"],
		},
	},
	y_offset = 8,
})

local cal_down = sbar.add("item", {
	position = "right",
	padding_left = -5,
	label = {
		color = colors.white,
		font = {
			family = settings.font.numbers,
			style = settings.font.style_map["Black"],
			size = settings.font.size_map["small"],
		},
	},
	y_offset = -8,
})

-- Double border for calendar using a single item bracket
local cal_bracket = sbar.add("bracket", { cal_up.name, cal_down.name }, {
	background = {
		color = colors.transparent,
		height = 36,
		border_color = colors.grey,
	},
	update_freq = 30,
})

-- Padding item required because of bracket
local spacing = sbar.add("item", { position = "right", width = 30 })

cal_bracket:subscribe({ "forced", "routine", "system_woke" }, function(env)
	local up_value = string.format("%s %d", os.date("%a %b"), tonumber(os.date("%d")))
	if #up_value < 10 then
		spacing:set({ width = 18 })
	end
	local down_value = string.format("%d:%s", tonumber(os.date("%I")), os.date("%M %p"))
	cal_up:set({ label = { string = up_value } })
	cal_down:set({ label = { string = down_value } })
end)

local function click_event(env)
	sbar.exec(settings.calendar.click_script)
end

cal_up:subscribe("mouse.clicked", click_event)
cal_down:subscribe("mouse.clicked", click_event)
