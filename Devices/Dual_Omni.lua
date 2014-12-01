--Dual Omnis

local manip_one = Devices.Sensable.PhantomOmni{
	name = "Omni2",
	forces = true,
	scale = 4.0
}
local right = translateDevice{
	manip_one,
	translation = {0.6, 1.0, -0.5}
}
addManipulator(right)

local manip_two = Devices.Sensable.PhantomOmni{
	name = "Omni1",
	forces = true,
	scale = 4.0
}
local left = translateDevice{
	manip_two,
	translation = {0.0, 1.0, -0.5}
}
addManipulator(left)