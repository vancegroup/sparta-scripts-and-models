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
	print("added to stack, now size is "..#self.matrixStack)
end

function McFlyIndex:reset()
	mats = self.matrixStack[#self.matrixStack]
	for i,v in ipairs(self.parts) do
		v.matrix = mats[v]
	end
	self.matrixStack = {}
	self:savePoint()
	print("reset now stack size is "..#self.matrixStack)
end

function McFlyIndex:goBack(steps)
	assert(steps > 0 , "Invalid steps back steps must be over 0")
	assert(steps < #self.matrixStack, "Invalid steps back no where to go")
	mats = self.matrixStack[steps+1]
	for i,v in ipairs(self.parts) do
		v.matrix = mats[v]
	end
	print("matrixStackSize b4 goback: "..#self.matrixStack)
	self.matrixStack = table_slice(self.matrixStack,steps+1,#self.matrixStack)
	print("matrixStackSize after goback: "..#self.matrixStack)
end

McFly = function(args)
	setmetatable(args, MFMT)
	assert(args.parts, "must supply parts to track in time!")
	args.matrixStack = {}
	args:savePoint()
	return args
end
