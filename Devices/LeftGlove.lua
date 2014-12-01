--Left Glove

-- Uses 5DT SDK driver, not VRPN

addDevice(
	Devices.Gadgeteer.Glove{
		position = "LeftGlove",
		options = "USB1",
		hardware = "GloveHardware5DT",
		reportType = "KalmanFilter", -- "KalmanFilter", "Raw", "HardwareCalibrated", "GloveToolsCalibrated"
		calibFile = "assets/calibrations/calib-left-5dt.txt",
	}
)
