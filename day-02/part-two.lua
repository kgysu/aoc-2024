-- local file = io.open("test-input.txt", "r")
local file = io.open("input.txt", "r")

if not file then
	print("Error: Unable to open file.")
	return
end

local function splitBySpace(line)
	local nums = {}
	for num in string.gmatch(line, "%S+") do
		table.insert(nums, tonumber(num))
	end
	return nums
end

local function isOnlyIncreasing(nums)
	for i = 1, #nums - 1 do
		if nums[i] >= nums[i + 1] then
			return false
		end
	end
	return true
end

local function isOnlyDecreasing(nums)
	for i = 1, #nums - 1 do
		if nums[i] <= nums[i + 1] then
			return false
		end
	end
	return true
end

local function hasSafeDiff(nums)
	for i = 1, #nums - 1, 1 do
		local diff = nums[i] - nums[i + 1]
		if diff > 0 and (diff < 1 or diff > 3) then
			return false
		end
		if diff < 0 and (diff > -1 or diff < -3) then
			return false
		end
	end
	return true
end

local function isSafe(nums)
	if not isOnlyIncreasing(nums) and not isOnlyDecreasing(nums) then
		return false
	end
	return hasSafeDiff(nums)
end

local function getSubset(tbl, index)
	local subset = {}
	for i, value in ipairs(tbl) do
		if not (i == index) then
			table.insert(subset, value)
		end
	end
	return subset
end

local count = 0

for line in file:lines() do
	if line == "" then
		goto continue
	end

	local nums = splitBySpace(line)
	if isSafe(nums) then
		count = count + 1
	else
		for i = 1, #nums do
			local subset = getSubset(nums, i)
			if isSafe(subset) then
				count = count + 1
				goto continue
			end
		end
	end

	::continue::
end

print("result=" .. count)

file:close()
