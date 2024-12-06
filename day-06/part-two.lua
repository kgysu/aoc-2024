package.path = package.path .. ";../?.lua"
local utils = require("utils.utils")
local file = io.open("input.txt", "r")

if not file then
	print("Error: Unable to open file.")
	return
end

local input = file:read("*all")
local grid = {}
local startPos = { x = 1, y = 1 }

local lineNr = 1
local charNr = 1
for i = 1, #input do
	local char = string.sub(input, i, i)

	if grid[lineNr] == nil then
		grid[lineNr] = {}
	end
	table.insert(grid[lineNr], { x = charNr, y = lineNr, c = char })

	if char == "^" then
		startPos.x = charNr
		startPos.y = lineNr
	elseif char == "\n" then
		lineNr = lineNr + 1
		charNr = 0
	end
	charNr = charNr + 1
end

local function newDir(dir)
	if dir == "u" then
		return "r"
	elseif dir == "r" then
		return "d"
	elseif dir == "d" then
		return "l"
	elseif dir == "l" then
		return "u"
	end
end

local goInDir = {
	u = function(x, y)
		return x, y - 1
	end,
	d = function(x, y)
		return x, y + 1
	end,
	r = function(x, y)
		return x + 1, y
	end,
	l = function(x, y)
		return x - 1, y
	end,
}

local function visit(v, y, x)
	if v[y] == nil then
		v[y] = {}
	end
	v[y][x] = true
end

local function countElements(arr)
	local count = 0
	for _, value in pairs(arr) do
		for _, _ in pairs(value) do
			count = count + 1
		end
	end
	return count
end

local max = countElements(grid)

local function walk(g, initPos)
	local dir = "u"
	local done = false
	local visited = {}
	local pos = { y = initPos.y, x = initPos.x }
	local count = 0
	while not done do
		local newX, newY = goInDir[dir](pos.x, pos.y)
		if newY >= #g or newY <= 0 or newX >= #g[pos.y] or newX <= 0 then
			done = true
			goto cont
		end

		local char = g[newY][newX].c
		if char == "#" then
			dir = newDir(dir)
		else
			pos.x = newX
			pos.y = newY
			visit(visited, pos.y, pos.x)
			count = count + 1
		end
		if count >= max then
			return visited, true
		end
		::cont::
	end
	return visited, false
end

local function deepClone(t)
	local copy = {}
	for key, value in pairs(t) do
		if type(value) == "table" then
			copy[key] = deepClone(value)
		else
			copy[key] = value
		end
	end
	return copy
end

local result = 0
local firstVisited = walk(grid, startPos)
for k, v in pairs(firstVisited) do
	for k2, _ in pairs(v) do
		if k == startPos.y and k2 == startPos.x then
			goto cont
		end

		local newGrid = deepClone(grid)
		newGrid[k][k2].c = "#"
		local _, hasLoop = walk(newGrid, startPos)
		if hasLoop then
			result = result + 1
		end
		::cont::
	end
end

print("result=" .. result)

file:close()
