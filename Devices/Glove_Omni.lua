--Add Omni
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