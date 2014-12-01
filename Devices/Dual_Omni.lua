--Dual Omnis


-- right
addDevice(
	translateDevice{
		translation = {0.6, 1.0, -0.5},
		Devices.Sensable.PhantomOmni{
			name = "Omni2",
			forces = true,
			scale = 4.0
		}
	}
)

-- left
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