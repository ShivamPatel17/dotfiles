local tbl = {}

-- checks if an item is already in a table
tbl.is_duplicate = function(_table, new_item)
	for _, item in ipairs(_table) do
		if item == new_item then
			return true
		end
	end
	return false
end

-- creates a table by splitting a given string by new lines
tbl.from_string = function(input)
	local result = {}
	for line in input:gmatch("([^\n]*)\n?") do
		if line ~= "" then
			table.insert(result, line)
		end
	end
	return result
end

-- merges two tables, overwriting the default values with the new ones
tbl.merge = function(default, overwrite)
	for k, v in pairs(overwrite) do
		if type(v) == "table" and type(default[k]) == "table" and not tbl.is_array_like(v) then
			tbl.merge(default[k], v)
		else
			default[k] = v
		end
	end
end

-- returns the keys of a table
tbl.keys = function(_table)
	local keys = {}
	for k, _ in pairs(_table) do
		table.insert(keys, k)
	end
	return keys
end

tbl.print = function(_table)
	for key, value in pairs(_table) do
		print(key, value)
	end
end

-- copies a table
tbl.copy = function(original)
	local copy = {}
	for key, value in pairs(original) do
		if type(value) == "table" then
			copy[key] = tbl.copy(value)
		else
			copy[key] = value
		end
	end
	return copy
end

-- returns the index (not the key) of a value in a table
tbl.get_index_by_value = function(_table, value)
	local i = 1
	for _, val in pairs(_table) do
		if val == value then
			return i
		end
		i = i + 1
	end
	return -1
end

-- checks if a table is array-like
tbl.is_array_like = function(_table)
	if type(_table) ~= "table" then
		return false
	end
	local i = 0
	for _ in pairs(_table) do
		i = i + 1
		if _table[i] == nil then
			return false
		end
	end
	return true
end

return tbl
