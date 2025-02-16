local colors = require("colors")
local settings = require("settings")

-- this is to listen to aerospace_workspace_change events and trigger a relabeling of the items
local aerospace_listener = sbar.add("item", "aerospace_listener")

local function update_workspaces(result, exit_code)
	local workspaces = {}
	local focused_workspace = 0

	if exit_code ~= 0 then
		print("aerospace command did not result exit code 0")
	end

	if result then
		for line in result:gmatch("[^\r\n]+") do
			if line:match("^FOCUSED_WORKSPACE=") then
				-- Extract the focused workspace value
				focused_workspace = line:match("FOCUSED_WORKSPACE=(%S+)")
			else
				local apple_space, workspace_id = line:match("(%S+)%s+(%S+)")
				workspaces[apple_space] = workspace_id
			end
		end

		for apple_space, workspace_id in pairs(workspaces) do
			local aesp_item_name = "aerospace_" .. apple_space
			local aerospace_item = sbar.query(aesp_item_name)

			-- sbar.query will return a table if there's a math
			if type(aerospace_item) == "table" then
				local labelstr = workspace_id
				if focused_workspace == workspace_id then
					labelstr = workspace_id .. "*"
				end
				sbar.set(aesp_item_name, {
					space = apple_space,
					label = {
						string = labelstr,
					},
				})
			else
				sbar.add("item", aesp_item_name, {
					space = apple_space,
					position = "left",
					icon = {
						drawing = false,
					},
					label = {
						font = {
							style = settings.font.style_map["Black"],
							size = settings.font.size_map["large"],
						},
						padding_right = 10,
						padding_left = 8,
						string = workspace_id,
					},
					background = {
						height = 30,
						color = colors.bg2,
						border_color = colors.black,
						border_width = 1,
						padding_right = 1,
						padding_left = 1,
					},
					padding_left = 1,
					padding_right = 1,
				})
			end
		end
	end
end

aerospace_listener:subscribe("aerospace_workspace_change", function(env)
	sbar.exec(
		"aerospace list-workspaces --monitor all --visible --format '%{monitor-appkit-nsscreen-screens-id} %{workspace}' | awk '{print} END {print \"FOCUSED_WORKSPACE="
			.. env["FOCUSED_WORKSPACE"]
			.. "\"}'",
		update_workspaces
	)
end)
