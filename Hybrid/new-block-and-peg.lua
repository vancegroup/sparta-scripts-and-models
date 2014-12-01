require "AddAppDirectory"
AddAppDirectory(true)

defineSimulationParameters{
	maxStiffness = 300.0,
	maxAngularStiffness = .1,
--	limitCouplerDampingForce = true,
}

partDensity = 10
voxSize = 0.0045

myScale = .5
zPos = -.75
xOffset = 0
yOffset = 0

if os.getenv("COMPUTERNAME") == "COMRADE" then
	print("On Comrade")
elseif os.getenv("COMPUTERNAME") == "METAL-RENDER" then
	print("in METaL")
	zPos = 1
	xOffset = 1
	yOffset = 1
else
	print("On unrecognized machine.")
end

-- Convenience function modified from vrjugglua-model-loader
function color(node, color)
	local mat = osg.Material()
	mat:setColorMode(0x1201);
	mat:setAmbient (0x0408, osg.Vec4(color[1], color[2], color[3], 1.0))
	mat:setDiffuse (0x0408, osg.Vec4(0.2, 0.2, 0.2, 1.0))
	mat:setSpecular(0x0408, osg.Vec4(0.2, 0.2, 0.2, 1.0))
	mat:setShininess(0x0408, 1)
	local ss = node:getOrCreateStateSet()
	ss:setAttributeAndModes(mat, osg.StateAttribute.Values.ON+osg.StateAttribute.Values.OVERRIDE)
	return node
end

function addZCylinder(body, center, radius)
	local features = FeatureSet()
	local c = Cylinder()
	c.center = center
	c.normal = {0, 0, 1} -- it's along Z by definition...
	c.radius = radius
	features:insert(BoundaryFeature(c))
	local voxSize = body.voxelsize.value
	local added = 0
	local total = 0
	local function handleVoxel(x, y, z)
		total = total + 1
		local ptRad = math.sqrt((center[1] - x) ^ 2 + (center[2] - y) ^ 2)
		if math.abs(ptRad - radius) <= 1.5 * voxSize then
			added = added + 1
			body:addFeatureSet(features, x, y, z)
		end
		return 0
	end
	body:foreachSurfaceVoxel(handleVoxel)
	print(("Z cylinder added to %d of %d"):format(added, total))
end

function addPlane(body, point, normal, predicate)
	local features = FeatureSet()
	local p = Plane()
	p.point = point
	p.normal = normal -- it's along Z by definition...
	features:insert(BoundaryFeature(p))
	local added = 0
	local total = 0
	local voxSize = body.voxelsize.value
	local function handleVoxel(x, y, z)
		total = total + 1
		if predicate(voxSize, x, y, z) then
			added = added + 1
			body:addFeatureSet(features, x, y, z)
		end
		return 0
	end
	body:foreachSurfaceVoxel(handleVoxel)
	print(("Plane added to %d of %d"):format(added, total))
end

block = addObject{
	brep = true,
	position = {.1 + xOffset, 1 + yOffset, zPos},
	density = partDensity,
	voxelsize = voxSize,
	Transform{
		scale = myScale * .001,
		color(Model("block-with-hole.stl"), {0, .7, 0})
	}
}

addZCylinder(block, {0,0,0}, .15 * myScale)
assert(block:getFeatureSet(1).size == 1, "Feature set ID 1 is the one we just added with a single feature")

--[[ Plane interacts badly with cylinder when assigned in this crude way
addPlane(block, {0,0,-.1 * myScale}, {0, 0, -1}, function(voxSize, x, y, z) return math.abs(z + .1 * myScale) <= voxSize end)
addPlane(block, {0,0,0.1 * myScale}, {0, 0, 1}, function(voxSize, x, y, z) return math.abs(z - .1 * myScale) <= voxSize end)
]]


peg = addObject{
	brep = true,
	density = partDensity,
	position = {.75 + xOffset, 1 + yOffset, zPos},
	voxelsize = voxSize,
	Transform{
		scale = myScale * 0.001,
		color(Model("pin-for-block.stl"), {0, 0, .7})
	}
}

addZCylinder(peg, {0,0,0}, .140 * myScale)
assert(peg:getFeatureSet(1).size == 1, "Feature set ID 1 is the one we just added with a single feature")
--[[ Plane interacts badly with cylinder when assigned in this crude way
addPlane(peg, {0,0,-.2 * myScale}, {0, 0, -1}, function(voxSize, x, y, z) return math.abs(z + .2 * myScale) <= voxSize end)
addPlane(peg, {0,0,0.2 * myScale}, {0, 0, 1}, function(voxSize, x, y, z) return math.abs(z - .2 * myScale) <= voxSize end)
]]

function setHybridEnabled(val)
	simulation:runFunctionWithSimulationPaused(function()
		block:setHybridEnabled(val)
		peg:setHybridEnabled(val)
	end)
end

function dumpSimStats()
	simulation:runFunctionWithSimulationPaused(function()
		print("Frames:", simulation.frame)
		print("Collision frames:", simulation.collisionFrames)
		print("Overruns:", simulation.overruns)
	end)
end


simulation:startInSchedulerThread()

print [[

Features of this hybrid method demo:
 - setHybridEnabled(true) will enable the DoF restoration (on by default)
 - setHybridEnabled(false) will disable the DoF restoration

 - dumpSimStats() will print performance statistics
  (number of frames, number of collision frames, and number of overruns)
]]
