
function FisherYatesShuffle(input)
	-- Seed the random number generator
	math.randomseed(os.time())
	--Make sure to call this otherwise it gives the same value each time
	--http://lua-users.org/lists/lua-l/2007-03/msg00553.html
	math.random(1, 2)

	print(string.format("Shuffling %d elements...", #input))
	-- initialize array to 0
	local randomOrder = {}
	for i = 1, #input do
		table.insert(randomOrder, 0)
	end

	randomOrder[1] = input[1]

	for i = 2, #input do
		local j = math.random(1, i)
		randomOrder[i] = randomOrder[j]
		randomOrder[j] = input[i]
	end

	return randomOrder
end