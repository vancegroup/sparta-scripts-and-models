--Left Omni

local dev = Devices.Sensable.PhantomOmni{
	name = "Omni1",
	forces = true,
	scale = 4.0
}
local left = translateDevice{
	dev,
	translation = {0.0, 1.0, -0.5}
}
addDevice(left)
