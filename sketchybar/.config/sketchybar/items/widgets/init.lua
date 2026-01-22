local settings = require("settings")
local tbl = require("utils.tbl")

local widgets = {
	"weather",
	"restart",
	"clipboard",
	"battery",
	"volume",
	"wifi",
	"cpu",
	"ram",
	"claude",
}

for _, widget in ipairs(widgets) do
	if tbl.get_index_by_value(settings.hide_widgets, widget) == -1 then
		require("items.widgets." .. widget)
	end
end
