
require("getScriptFilename")
vrjLua.appendToModelSearchPath(getScriptFilename())

--Load in models
local voxSize = 0.003
local densitySize = 20
local scaleSize = 1.0

key = addObject{
	voxelsize = voxSize,
	position = {0.2, 0.9, -0.5},
	density = densitySize,
	Transform{
		scale = scaleSize,
		Model("Models/Key.osg")
	}
}

lock1 = addObject{
	voxelsize = voxSize,
	position = {0.4, 0.9, -0.5},
	density = densitySize,
	Transform{
		scale = scaleSize,
		Model("Models/Lock1.osg")
	}
}

lock2 = addObject{
	voxelsize = voxSize,
	position = {0.6, 0.9, -0.5},
	density = densitySize,
	Transform{
		scale = scaleSize,
		Model("Models/lck2.osg")
	}
}