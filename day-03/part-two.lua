local file = io.open("input.txt", "r")

if not file then
	print("Error: Unable to open file.")
	return
end

local result = 0

for line in file:lines() do
	local enabled = true
	local lastOb = 0

	for i = 1, #line do
		local char = string.sub(line, i, i)

		if char == ")" then
			if string.sub(line, i - 3, i) == "do()" then
				enabled = true
				goto continue
			end
			if string.sub(line, i - 6, i) == "don't()" then
				enabled = false
				goto continue
			end

			if string.sub(line, lastOb - 3, lastOb) == "mul(" then
				local nums = string.sub(line, lastOb + 1, i - 1)
				if not string.match(nums, "^%d+%,%d+$") then
					goto continue
				end
				local mul = 1
				for val in string.gmatch(nums, "%d+") do
					mul = mul * tonumber(val)
				end

				if enabled then
					result = result + mul
				end
			end
		elseif char == "(" then
			lastOb = i
		end

		::continue::
	end
end

print("result=" .. result)

file:close()
