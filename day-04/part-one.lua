local file = io.open("input.txt", "r")

if not file then
	print("Error: Unable to open file.")
	return
end

local key = "XMAS"
local result = 0

local input = file:read("*all")
local start, _ = string.find(input, "\n")
local lineLenght = start

for i = 1, #input do
	local char = string.sub(input, i, i)

	if char == "X" then
		local right = char
		local left = char
		local up = char
		local down = char
		local diagDownRight = char
		local diagDownLeft = char
		local diagUpRight = char
		local diagUpLeft = char

		for y = 1, 3 do
			local nextRight = i + y
			local nextLeft = i - y
			local nextUp = i - (lineLenght * y)
			local nextDown = i + (lineLenght * y)
			local nextDiagDownRight = i + (lineLenght * y) + y
			local nextDiagDownLeft = i + (lineLenght * y) - y
			local nextDiagUpRight = i - (lineLenght * y) + y
			local nextDiagUpLeft = i - (lineLenght * y) - y

			if nextRight > 0 and nextRight < #input then
				right = right .. string.sub(input, nextRight, nextRight)
			end
			if nextLeft > 0 and nextLeft < #input then
				left = left .. string.sub(input, nextLeft, nextLeft)
			end
			if nextUp > 0 and nextUp < #input then
				up = up .. string.sub(input, nextUp, nextUp)
			end
			if nextDown > 0 and nextDown < #input then
				down = down .. string.sub(input, nextDown, nextDown)
			end
			if nextDiagDownRight > 0 and nextDiagDownRight < #input then
				diagDownRight = diagDownRight .. string.sub(input, nextDiagDownRight, nextDiagDownRight)
			end
			if nextDiagDownLeft > 0 and nextDiagDownLeft < #input then
				diagDownLeft = diagDownLeft .. string.sub(input, nextDiagDownLeft, nextDiagDownLeft)
			end
			if nextDiagUpRight > 0 and nextDiagUpRight < #input then
				diagUpRight = diagUpRight .. string.sub(input, nextDiagUpRight, nextDiagUpRight)
			end
			if nextDiagUpLeft > 0 and nextDiagUpLeft < #input then
				diagUpLeft = diagUpLeft .. string.sub(input, nextDiagUpLeft, nextDiagUpLeft)
			end
		end

		if right == key then
			result = result + 1
		end
		if left == key then
			result = result + 1
		end
		if up == key then
			result = result + 1
		end
		if down == key then
			result = result + 1
		end
		if diagDownRight == key then
			result = result + 1
		end
		if diagDownLeft == key then
			result = result + 1
		end
		if diagUpRight == key then
			result = result + 1
		end
		if diagUpLeft == key then
			result = result + 1
		end
	end
end

print("result=" .. result)

file:close()
