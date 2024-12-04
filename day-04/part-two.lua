local file = io.open("input.txt", "r")

if not file then
	print("Error: Unable to open file.")
	return
end

local result = 0

local input = file:read("*all")
local start, _ = string.find(input, "\n")
local lineLenght = start

for i = 1, #input do
	local char = string.sub(input, i, i)

	if char == "A" then
		local diag1 = char
		local nextDiagDownRight = i + lineLenght + 1
		local nextDiagUpLeft = i - lineLenght - 1

		if nextDiagDownRight > 0 and nextDiagDownRight < #input then
			diag1 = diag1 .. string.sub(input, nextDiagDownRight, nextDiagDownRight)
		end
		if nextDiagUpLeft > 0 and nextDiagUpLeft < #input then
			diag1 = string.sub(input, nextDiagUpLeft, nextDiagUpLeft) .. diag1
		end

		local diag2 = char
		local nextDiagDownLeft = i + lineLenght - 1
		local nextDiagUpRight = i - lineLenght + 1

		if nextDiagDownLeft > 0 and nextDiagDownLeft < #input then
			diag2 = diag2 .. string.sub(input, nextDiagDownLeft, nextDiagDownLeft)
		end
		if nextDiagUpRight > 0 and nextDiagUpRight < #input then
			diag2 = string.sub(input, nextDiagUpRight, nextDiagUpRight) .. diag2
		end

		if (diag1 == "MAS" or diag1 == "SAM") and (diag2 == "MAS" or diag2 == "SAM") then
			result = result + 1
		end
	end
end

print("result=" .. result)

file:close()
