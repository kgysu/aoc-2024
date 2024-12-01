-- local file = io.open("test-input.txt", "r")
local file = io.open("input.txt", "r")

if not file then
	print("Error: Unable to open file.")
	return
end

local function getDistance(a, b)
	if a > b then
		return a - b
	else
		return b - a
	end
end

local list1 = {}
local list2 = {}

for line in file:lines() do
	for first, second in string.gmatch(line, "(%d+)%s+(%d+)") do
		table.insert(list1, first)
		table.insert(list2, second)
	end
end

table.sort(list1)
table.sort(list2)

local res = 0
for i, n in ipairs(list1) do
	res = res + getDistance(n, list2[i])
end

print("result=" .. res)

file:close()
