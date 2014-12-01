function rightOmni()
	dev = Devices.Sensable.PhantomOmni{
		name = "Omni2",
		forces = true,
		scale = 4.0
	}
	right = translateDevice{
		dev,
		translation = {0.6, 1.0, -0.5}
	}
	addDevice(right)
end

function leftOmni()
	dev = Devices.Sensable.PhantomOmni{
		name = "Omni1",
		forces = true,
		scale = 4.0
	}
	left = translateDevice{
		dev,
		translation = {0.0, 1.0, -0.5}
	}
	addDevice(left)
end

function rightGlove()
	right = Devices.Gadgeteer.Glove{position = "RightGlove",
		options = "USB0",
		hardware = "GloveHardware5DT",
		reportType = "KalmanFilter", -- "KalmanFilter", "Raw", "HardwareCalibrated", "GloveToolsCalibrated"
		calibFile = "assets/calibrations/calib-right-5dt.txt",
	}
	addDevice(right)
end

function leftGlove()
	left = Devices.Gadgeteer.Glove{position = "LeftGlove",
		options = "USB1",
		hardware = "GloveHardware5DT",
		reportType = "KalmanFilter", -- "KalmanFilter", "Raw", "HardwareCalibrated", "GloveToolsCalibrated"
		calibFile = "assets/calibrations/calib-left-5dt.txt",
	}
	addDevice(left)
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