--Left Omni

local manip = Devices.Sensable.PhantomOmni{
	name = "Omni1",
	forces = true,
	scale = 4.0
}
local left = translateDevice{
	manip,
	translation = {0.0, 1.0, -0.5}
}
addManipulator(left)
