local utils = require("../utils/utils.lua")
local file = io.open("input.txt", "r")

if not file then
	print("Error: Unable to open file.")
	return
end

local function getMiddleValue(array)
	local length = #array
	if length == 0 then
		return nil -- Return nil if the array is empty
	end

	-- For odd length, return the middle element
	if length % 2 == 1 then
		return array[math.floor(length / 2) + 1]
	else
		-- For even length, return the lower middle element (or you can return the higher middle)
		return array[math.floor(length / 2)]
	end
end

local rules = {}
local input = {}

for line in file:lines() do
	if not (line == "") then
		if string.find(line, "|") then
			local pair = utils.splitNums(line, "|")
			table.insert(rules, { pair[1], pair[2] })
		else
			local values = utils.splitNums(line, ",")
			table.insert(input, values)
		end
	end
end

local function isLineCorrectlyOrdered(line)
	for i, value in ipairs(line) do
		local valsNotBefore = {}
		for _, rule in ipairs(rules) do
			if value == rule[1] then
				table.insert(valsNotBefore, rule[2])
			end
		end

		for j = 1, i do
			for _, nb in ipairs(valsNotBefore) do
				if line[j] == nb then
					return false
				end
			end
		end
	end
	return true
end

local result = 0

for _, values in ipairs(input) do
	if isLineCorrectlyOrdered(values) then
		result = result + getMiddleValue(values)
	end
end

print("result=" .. result)

file:close()