--Use handedness that was passed in as a parameter in the launcher

--Glove in right, Omni in left
if (domHand == "left") then
	glove = Devices.Gadgeteer.Glove{position = "RightGlove",
		options = "USB0",
		hardware = "GloveHardware5DT",
		reportType = "KalmanFilter", -- "KalmanFilter", "Raw", "HardwareCalibrated", "GloveToolsCalibrated"
		calibFile = "assets/calibrations/calib-right-5dt.txt",
	}
	addManipulator(glove)
	manip = Devices.Sensable.PhantomOmni{
		name = "Omni1",
		forces = true,
		scale = 8.0
	}
	omni = translateDevice{
		manip,
		translation = {0.0, 1.0, -0.5}
	}
	addManipulator(omni)
end

--Omni in right, Glove in left
if (domHand == "right") then
	manip = Devices.Sensable.PhantomOmni{
		name = "Omni2",
		forces = true,
		scale = 8.0
	}
	omni = translateDevice{
		manip,
		translation = {0.6, 1.0, -0.5}
	}
	addManipulator(omni)
	glove = Devices.Gadgeteer.Glove{position = "LeftGlove",
		options = "USB1",
		hardware = "GloveHardware5DT",
		reportType = "KalmanFilter", -- "KalmanFilter", "Raw", "HardwareCalibrated", "GloveToolsCalibrated"
		calibFile = "assets/calibrations/calib-left-5dt.txt",
	}
	addManipulator(glove)
end

function makeGloveTransparent()
	--hide the glove
	hideInView(glove)

	--make glove transparent and add it
	local osgGlove = getTransformNodeForCoordinateFrame(glove):getChild(0)
	local transparentGroup = TransparentGroup{osgGlove}
	RelativeTo.World:addChild(transparentGroup)
end