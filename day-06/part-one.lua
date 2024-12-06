local file = io.open("input.txt", "r")

if not file then
	print("Error: Unable to open file.")
	return
end

local input = file:read("*all")
local grid = {}
local pos = { x = 1, y = 1 }

local lineNr = 1
local charNr = 1
for i = 1, #input do
	local char = string.sub(input, i, i)

	if grid[lineNr] == nil then
		grid[lineNr] = {}
	end
	table.insert(grid[lineNr], { x = charNr, y = lineNr, c = char })

	if char == "^" then
		pos.x = charNr
		pos.y = lineNr
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

local visited = {}

local function visit(y, x)
	if visited[y] == nil then
		visited[y] = {}
	end
	visited[y][x] = true
end

local dir = "u"
local done = false

while not done do
	local newX, newY = goInDir[dir](pos.x, pos.y)
	if newY >= #grid or newY <= 0 or newX >= #grid[pos.y] or newX <= 0 then
		done = true
		goto cont
	end

	local char = grid[newY][newX].c
	if char == "#" then
		dir = newDir(dir)
	else
		pos.x = newX
		pos.y = newY
		visit(pos.y, pos.x)
	end
	::cont::
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

print("result=" .. countElements(visited))

file:close()
