

require("getScriptFilename")
vrjLua.appendToModelSearchPath(getScriptFilename())

--Load in models
voxSize = 0.003
densitySize = 20
scaleSize = 1.0

local pos = {0.8, 0.9, -0.5}

pieceone = addObject{
	voxelsize = voxSize,
	position = pos,
	density = densitySize,
	Transform{
		scale = scaleSize,
		Model("Models/Clutch-FlywheelPart1.ive")
	}
}
piecetwo = addObject{
	voxelsize = voxSize,
	position = pos,
	density = densitySize,
	Transform{
		scale = scaleSize,
		Model("Models/Clutch-FlywheelPart2.ive")
	}
}
piecethree = addObject{
	voxelsize = voxSize,
	position = pos,
	density = densitySize,
	Transform{
		scale = scaleSize,
		Model("Models/Clutch-FlywheelPart3.ive")
	}
}
piecefour = addObject{
	voxelsize = voxSize,
	position = pos,
	density = densitySize,
	Transform{
		scale = scaleSize,
		Model("Models/Clutch-FlywheelPart4.ive")
	}
}