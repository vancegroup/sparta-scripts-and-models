-- Right Glove

-- Uses 5DT SDK driver, not VRPN

addDevice(
	Devices.Gadgeteer.Glove{
		position = "RightGlove",
		options = "USB0",
		hardware = "GloveHardware5DT",
		reportType = "KalmanFilter", -- "KalmanFilter", "Raw", "HardwareCalibrated", "GloveToolsCalibrated"
		calibFile = "assets/calibrations/calib-right-5dt.txt",
	}
)