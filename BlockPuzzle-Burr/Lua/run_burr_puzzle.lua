require("getScriptFilename")
vrjLua.appendToModelSearchPath(getScriptFilename())

params = defineSimulationParameters{
	--This is a good parameter for the omnis
	maxStiffness = 300.0,
	parts = 6
}

function runfile(fn)
	dofile(vrjLua.findInModelSearchPath(fn))
end

--Takes two arguments:
--handedness = "left" or "right"
--devices = "dualomni" or "gloveomni"

--Load in models
voxSize = 0.003
densitySize = 20
scaleSize = 4.0

switchToMinimalRoom()

baseblock = addObject{
	voxelsize = voxSize,
	position = {0.05, 0.8, -0.5},
	density = densitySize,
	Transform{
		scale = scaleSize,
		Model("../../GOALI/Models/Burr/BaseBlock.ive")
	}
}
block1 = addObject{
	voxelsize = voxSize,
	position = {0.35, 0.8, -0.5},
	density = densitySize,
	Transform{
		scale = scaleSize,
		Model("../../GOALI/Models/Burr/Block1.ive")
	}
}
block2 = addObject{
	voxelsize = voxSize,
	position = {0.65, 0.8, -0.5},
	density = densitySize,
	Transform{
		scale = scaleSize,
		Model("../../GOALI/Models/Burr/Block2.ive")
	}
}
block3 = addObject{
	voxelsize = voxSize,
	position = {0.05, 1.0, -0.5},
	density = densitySize,
	Transform{
		scale = scaleSize,
		Model("../../GOALI/Models/Burr/Block3.ive")
	}
}
block4 = addObject{
	voxelsize = voxSize,
	position = {0.35, 1.0, -0.5},
	density = densitySize,
	Transform{
		scale = scaleSize,
		Model("../../GOALI/Models/Burr/Block4.ive")
	}
}
block5 = addObject{
	voxelsize = voxSize,
	position = {0.65, 1.0, -0.5},
	density = densitySize,
	Transform{
		scale = scaleSize,
		Model("../../GOALI/Models/Burr/Block5.ive")
	}
}

--setup devices based on parameters
runfile("devices.lua")

simulation:startInSchedulerThread()