--Left Omni - Right Glove

addDevice(
	translateDevice{
		translation = {0.0, 1.0, -0.5},
		Devices.Sensable.PhantomOmni{
			name = "Omni1",
			forces = true,
			scale = 4.0
		}
	}
)


addDevice(
	Devices.Gadgeteer.Glove{
		position = "RightGlove",
		options = "USB0",
		hardware = "GloveHardware5DT",
		reportType = "KalmanFilter", -- "KalmanFilter", "Raw", "HardwareCalibrated", "GloveToolsCalibrated"
		calibFile = "assets/calibrations/calib-right-5dt.txt",
	}
)