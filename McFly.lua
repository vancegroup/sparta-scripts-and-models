--helper function for splicing tables as lua does not support it natively :(
local function table_slice (values,i1,i2)
	local res = {}
	local n = #values

	i1 = i1 or 1
	i2 = i2 or n
	if i2 < 0 then
		i2 = n + i2 + 1
	elseif i2 > n then
		i2 = n
	end
	if i1 < 1 or i1 > n then
		return {}
	end
	local k = 1
	for i = i1,i2 do
		res[k] = values[i]
		k = k + 1
	end
	return res
end

local McFlyIndex = {ismcfly = true}
local MFMT = { __index = McFlyIndex }

function McFlyIndex:savePoint()
	local SP = {}
	for i,v in ipairs(self.parts) do
		SP[v] = v.matrix
	end
	table.insert(self.matrixStack,1,SP)
end

function McFlyIndex:reset()
	mats = self.matrixStack[#self.matrixStack]
	for i,v in ipairs(self.parts) do
		v.matrix = mats[v]
	end
	self.matrixStack = {}
end

function McFlyIndex:goBack(steps)
	assert(steps < 1 or steps > #self.matrixStack, "Invalid steps back..")
	mats = self.matrixStack[steps]
	for i,v in ipairs(self.parts) do
		v.matrix = mats[v]
	end
	self.matrixStack = table_slice(self.matrixStack,steps+1,#self.matrixStack)
end

McFly = function(args)
	assert(args.parts, "must supply parts to track in time!")
	args.matrixStack = {}
	args:savePoint()
	setmetatable(args, MFMT)
	return parts
end
