local lunajson = require("lunajson")

local file = require("utils.file")
local tbl = require("utils.tbl")

local function load_config()
	local config = {
		calendar = {
			click_script = "open -a Calendar",
		},
		clipboard = {
			max_items = 5,
		},
		font = {
			text = "JetBrainsMono Nerd Font", -- Used for text
			numbers = "JetBrainsMono Nerd Font", -- Used for numbers
			family = "JetBrainsMono Nerd Font",
			size_map = {
				["xsmall"] = 12.0,
				["small"] = 14.0,
				["medium"] = 16.0,
				["large"] = 20.0,
				["xlarge"] = 24.0,
			},
			style_map = {
				["Regular"] = "Regular",
				["Semibold"] = "Medium",
				["Bold"] = "SemiBold",
				["Heavy"] = "Bold",
				["Black"] = "ExtraBold",
			},
		},
		group_paddings = 5,
		hide_widgets = {},
		icons = "NerdFont", -- alternatively available: NerdFont
		paddings = 3,
		python_command = "python",
		weather = {
			location = "New+York+City", -- https://github.com/chubin/wttr.in
			use_shortcut = false,
		},
	}

	-- allows for json config, but I don't think I'll every really use this. Would rather just update the config above
	local config_filepath = os.getenv("CONFIG_DIR") .. "/config.json"
	local content, error = file.read(config_filepath)
	if not error then
		local json_content = lunajson.decode(content)
		tbl.merge(config, json_content)
	end
	return config
end

return load_config()
