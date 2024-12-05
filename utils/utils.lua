local M = {}

M.printTable = function(t, indent)
	indent = indent or ""
	for key, value in pairs(t) do
		if type(value) == "table" then
			print(indent .. key .. ":")
			M.printTable(value, indent .. "  ") -- Recursively print nested tables
		else
			print(indent .. key .. ": " .. tostring(value))
		end
	end
end

M.printValues = function(t)
	local res = ""
	for _, value in ipairs(t) do
		res = res .. value .. ", "
	end
	print(res)
end

M.split = function(str, delimiter)
	local result = {}
	for part in string.gmatch(str, "([^" .. delimiter .. "]+)") do
		table.insert(result, part)
	end
	return result
end

M.splitNumbers = function(str, delimiter)
	local result = {}
	for part in string.gmatch(str, "([^" .. delimiter .. "]+)") do
		table.insert(result, tonumber(part))
	end
	return result
end

M.tableContains = function(table, element)
	for _, value in pairs(table) do
		if value == element then
			return true
		end
	end
	return false
end

return M
