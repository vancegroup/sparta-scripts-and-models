--Dual Omnis

local dev_one = Devices.Sensable.PhantomOmni{
	name = "Omni2",
	forces = true,
	scale = 4.0
}
local right = translateDevice{
	dev_one,
	translation = {0.6, 1.0, -0.5}
}
addDevice(right)

local dev_two = Devices.Sensable.PhantomOmni{
	name = "Omni1",
	forces = true,
	scale = 4.0
}
local left = translateDevice{
	dev_two,
	translation = {0.0, 1.0, -0.5}
}
addDevice(left)