local file = io.open("input.txt", "r")

if not file then
	print("Error: Unable to open file.")
	return
end

local result = 0

for line in file:lines() do
	for match in string.gmatch(line, "mul%(%d+%,%d+%)") do
		local mul = 1
		for num in string.gmatch(match, "%d+") do
			mul = mul * num
		end
		result = result + mul
	end
end

print("result=" .. result)

file:close()
