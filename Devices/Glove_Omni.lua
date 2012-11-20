--Add Devices
if (handedness == "right" or handedness == nil) then
	manip = Manipulators.Sensable.PhantomOmni{
		name = "Omni2",
		forces = true,
		scale = 4.0
	}
	right = translateManipulator{
		manip,
		translation = {0.6, 1.0, -0.5}
	}
	addManipulator(right)
	left = Manipulators.Gadgeteer.Glove{position = "LeftGlove",
		options = "USB1",
		hardware = "GloveHardware5DT",
		reportType = "KalmanFilter", -- "KalmanFilter", "Raw", "HardwareCalibrated", "GloveToolsCalibrated"
		calibFile = "assets/calibrations/calib-left-5dt.txt",
	}
	addManipulator(left)
end

if (handedness == "left") then
	manip = Manipulators.Sensable.PhantomOmni{
		name = "Omni1",
		forces = true,
		scale = 4.0
	}
	left = translateManipulator{
		manip,
		translation = {0.0, 1.0, -0.5}
	}
	addManipulator(left)
	right = Manipulators.Gadgeteer.Glove{position = "RightGlove",
		options = "USB0",
		hardware = "GloveHardware5DT",
		reportType = "KalmanFilter", -- "KalmanFilter", "Raw", "HardwareCalibrated", "GloveToolsCalibrated"
		calibFile = "assets/calibrations/calib-right-5dt.txt",
	}
	addManipulator(right)
end