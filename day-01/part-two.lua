-- local file = io.open("test-input.txt", "r")
local file = io.open("input.txt", "r")

if not file then
	print("Error: Unable to open file.")
	return
end

local function getSimilarytyScore(num, list)
	local count = 0
	for _, value in ipairs(list) do
		if num == value then
			count = count + 1
		end
	end
	-- print("num=" .. num .. " has count=" .. count)
	return num * count
end

local list1 = {}
local list2 = {}

for line in file:lines() do
	for first, second in string.gmatch(line, "(%d+)%s+(%d+)") do
		table.insert(list1, first)
		table.insert(list2, second)
	end
end

local res = 0
for _, n in ipairs(list1) do
	res = res + getSimilarytyScore(n, list2)
end

print("result=" .. res)

file:close()
