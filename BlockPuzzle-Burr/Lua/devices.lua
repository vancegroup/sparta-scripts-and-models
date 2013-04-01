--Use handedness variable that was passed in as a parameter in the launcher
--Use devices variable that was passed in as a parameter in the launcher

function leftGlove()
	glove = Manipulators.Gadgeteer.Glove{position = "LeftGlove",
		options = "USB1",
		hardware = "GloveHardware5DT",
		reportType = "KalmanFilter", -- "KalmanFilter", "Raw", "HardwareCalibrated", "GloveToolsCalibrated"
		calibFile = "assets/calibrations/calib-left-5dt.txt",
	}
	addManipulator(glove)
end

function rightGlove()
	glove = Manipulators.Gadgeteer.Glove{position = "RightGlove",
		options = "USB0",
		hardware = "GloveHardware5DT",
		reportType = "KalmanFilter", -- "KalmanFilter", "Raw", "HardwareCalibrated", "GloveToolsCalibrated"
		calibFile = "assets/calibrations/calib-right-5dt.txt",
	}
	addManipulator(glove)
end

function leftOmni()
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

function rightOmni()
	manip = Manipulators.Sensable.PhantomOmni{
		name = "Omni2",
		forces = true,
		scale = 3.0
	}
	omni = translateManipulator{
		manip,
		translation = {0.5, 1.0, -0.5}
	}
	addManipulator(omni)
end

if devices == "dualomni" then
	rightOmni()
	leftOmni()
end

if handedness == "left" then
	if devices == "gloveomni" then
		--Glove in right, Omni in left
		rightGlove()
		leftOmni()
	end
end

if handedness == "right" then
	if devices == "gloveomni" then
		--Omni in right, Glove in left
		rightOmni()
		leftGlove()
	end
end
