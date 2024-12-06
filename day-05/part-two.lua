package.path = package.path .. ";../?.lua"
local utils = require("utils.utils")
local file = io.open("input.txt", "r")

if not file then
	print("Error: Unable to open file.")
	return
end

local function getMiddleValue(array)
	local length = #array
	if length == 0 then
		return nil
	end

	if length % 2 == 1 then
		return array[math.floor(length / 2) + 1]
	else
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

local function sortByRules(a, b)
	for _, rule in ipairs(rules) do
		if a == rule[1] and b == rule[2] then
			return true
		elseif a == rule[2] and b == rule[1] then
			return false
		end
	end
	return true
end

local result = 0

for _, values in ipairs(input) do
	if not isLineCorrectlyOrdered(values) then
		while not isLineCorrectlyOrdered(values) do
			table.sort(values, sortByRules)
		end
		result = result + getMiddleValue(values)
	end
end

print("result=" .. result)

file:close()
