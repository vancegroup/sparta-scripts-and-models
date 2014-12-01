--Right Omni

local dev = Devices.Sensable.PhantomOmni{
	name = "Omni2",
	forces = true,
	scale = 4.0
}
local right = translateDevice{
	dev,
	translation = {0.6, 1.0, -0.5}
}
addDevice(right)

