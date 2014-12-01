--Right Omni

local manip = Manipulators.Sensable.PhantomOmni{
	name = "Omni2",
	forces = true,
	scale = 4.0
}
local right = translateDevice{
	manip,
	translation = {0.6, 1.0, -0.5}
}
addManipulator(right)

