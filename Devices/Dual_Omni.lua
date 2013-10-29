--Dual Omnis

local manip_one = Manipulators.Sensable.PhantomOmni{
	name = "Omni2",
	forces = true,
	scale = 4.0
}
local right = translateManipulator{
	manip_one,
	translation = {0.6, 1.0, -0.5}
}
addManipulator(right)

local manip_two = Manipulators.Sensable.PhantomOmni{
	name = "Omni1",
	forces = true,
	scale = 4.0
}
local left = translateManipulator{
	manip_two,
	translation = {0.0, 1.0, -0.5}
}
addManipulator(left)