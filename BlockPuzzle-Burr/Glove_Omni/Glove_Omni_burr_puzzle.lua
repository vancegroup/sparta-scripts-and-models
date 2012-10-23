require("getScriptFilename")
vrjLua.appendToModelSearchPath(getScriptFilename())

params = defineSimulationParameters{
	--This is a good parameter for the omnis
	maxStiffness = 300.0,
	parts = 6
}

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

--Use handedness that was passed in as a parameter in the launcher

--Glove in right, Omni in left
if handedness == "left" then
	glove = Manipulators.Gadgeteer.Glove{position = "RightGlove",
		options = "USB0",
		hardware = "GloveHardware5DT",
		reportType = "KalmanFilter", -- "KalmanFilter", "Raw", "HardwareCalibrated", "GloveToolsCalibrated"
		calibFile = "assets/calibrations/calib-right-5dt.txt",
	}
	addManipulator(glove)
	manip = Manipulators.Sensable.PhantomOmni{
		name = "Omni1",
		forces = true,
		scale = 3.0
	}
	omni = translateManipulator{
		manip,
		translation = {0.0, 1.0, -0.5}
	}
	addManipulator(omni)
end

--Omni in right, Glove in left
if handedness == "right" then
	manip = Manipulators.Sensable.PhantomOmni{
		name = "Omni2",
		forces = true,
		scale = 3.0
	}
	omni = translateManipulator{
		manip,
		translation = {0.8, 1.0, -0.5}
	}
	addManipulator(omni)
	glove = Manipulators.Gadgeteer.Glove{position = "LeftGlove",
		options = "USB1",
		hardware = "GloveHardware5DT",
		reportType = "KalmanFilter", -- "KalmanFilter", "Raw", "HardwareCalibrated", "GloveToolsCalibrated"
		calibFile = "assets/calibrations/calib-left-5dt.txt",
	}
	addManipulator(glove)
end

simulation:startInSchedulerThread()