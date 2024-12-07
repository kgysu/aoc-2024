local file = io.open("input.txt", "r")

if not file then
	print("Error: Unable to open file.")
	return
end

local function getNumbers(arr)
	local nums = {}
	for i = 2, #arr do
		table.insert(nums, arr[i])
	end
	return nums
end

local function splitExpression(expression)
	local arr = {}
	for num, op in string.gmatch(expression, "([^+*]+)([+*])") do
		table.insert(arr, num)
		table.insert(arr, op)
	end
	table.insert(arr, string.match(expression, "([^+*]+)$"))
	return arr
end

local function evaluateLeftToRight(arr)
	local result = tonumber(arr[1])

	for i = 2, #arr, 2 do
		local operator = arr[i]
		local num = tonumber(arr[i + 1])

		if operator == "+" then
			result = result + num
		elseif operator == "*" then
			result = result * num
		end
	end

	return result
end

local function generateCombinations(numbers)
	local combinations = {}

	local function combine(index, currentCombination)
		if index == #numbers then
			table.insert(combinations, currentCombination)
			return
		end

		combine(index + 1, currentCombination .. "+" .. numbers[index + 1])
		combine(index + 1, currentCombination .. "*" .. numbers[index + 1])
	end

	combine(1, tostring(numbers[1]))
	return combinations
end

local function check(target, numbers)
	local combinations = generateCombinations(numbers)

	for _, combination in ipairs(combinations) do
		local tokens = splitExpression(combination)

		local result = evaluateLeftToRight(tokens)
		if result == target then
			return true, combination
		end
	end

	return false, nil
end

local result = 0

for line in file:lines() do
	local matches = {}
	for match in string.gmatch(line, "%d+") do
		table.insert(matches, tonumber(match))
	end

	if #matches > 0 then
		local want = matches[1]
		local nums = getNumbers(matches)

		local res, _ = check(want, nums)
		if res then
			result = result + want
		end
	end
end

print("result=" .. result)

file:close()
