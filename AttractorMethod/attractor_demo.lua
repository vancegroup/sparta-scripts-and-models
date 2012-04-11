
params = defineSimulationParameters{
	maxStiffness = 300.0
}

yellow = addObject{
	voxelsize = 0.003,
	position = {0.0, 0.5, 0.0},
	density = 20,
	Transform{
		orientation = AngleAxis(Degrees(-90), Axis{1.0, 0.0, 0.0}),
		scale = 4.0,
		Model("models/attractor/Block1.ive")
	}
}

green = addObject{
	voxelsize = 0.003,
	position = {-.04, .54, -.04},
	density = 20,
	--scale = 10,
	Transform{
		orientation = AngleAxis(Degrees(90), Axis{0.0, 1.0, 0.0}),
		Transform{
			orientation = AngleAxis(Degrees(-180), Axis{1.0, 0.0, 0.0}),
			scale = 4.0,
			Model("models/attractor/Block2.ive"),
		}
	}
}
blue = addObject{
	voxelsize = 0.003,
	position = {0.001, .55, -.045},
	density = 20,
	--scale = 10,
	Transform{
		orientation = AngleAxis(Degrees(-90), Axis{1.0, 0.0, 0.0}),
		Transform{
			scale = 4.0,
			Model("models/attractor/Block3.ive"),
			orientation = AngleAxis(Degrees(-90), Axis{0.0, 1.0, 0.0}),
		}
	}
}

omni = Manipulators.Sensable.PhantomOmni{
	name = "Omni1",
	forces = true,
	scale = 20.0,
}

addAttractorForce{body1 = green, body2 = yellow, snapDist = .05, stiff = 250, lockLimit = 500, duplex = true}
addAttractorForce{body1 = blue, body2 = yellow, snapDist = .05, stiff = 150, lockLimit = 300}

yellow:setPosition(0, 1.5, 0)
green:setPosition(.4, 1.5, 0)
blue:setPosition(.8, 1.5, 0)


addManipulator(omni)

simulation:startInSchedulerThread()


