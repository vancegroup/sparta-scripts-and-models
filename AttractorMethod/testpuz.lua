
params = defineSimulationParameters{
	maxStiffness = 300.0
}

scale = 5.0
pieceBlue = Transform{
	scale = 5.0,
	Transform{
		position = {-.1, .3, 0},
		orientation = AngleAxis(Degrees(90), Axis{0.0, 0.0, 1.0}),
		Model ([[V:\Applications\vancegroup\GOALI\Burr\Block3.ive]])
	}
}
pieceYellow = Transform{
	scale = 5.0,
	Transform{
		position = {-.09, .29, -.099},
		orientation = AngleAxis(Degrees(90), Axis{0.0, 1.0, 0.0}),
		Transform{
			position = {-.1, 0, 0},
			orientation = AngleAxis(Degrees(-90), Axis{1.0, 0.0, 0.0}),
			Model ([[V:\Applications\vancegroup\GOALI\Burr\Block1.ive]])
		}
	}
}
pieceGreen = Transform{
	scale = 5.0,
	Transform{
		position = {-.08999, .2999, 0.011},
		orientation = AngleAxis(Degrees(90), Axis{1.0, 0.0, 0.0}),
		Model ([[V:\Applications\vancegroup\GOALI\Burr\Block2.ive]])
	}
}
piecePurple = Transform{
	scale = 5.0,
	Transform{
		position = {.22, .2, 0},
		orientation = AngleAxis(Degrees(90), Axis{0.0, 0.0, 1.0}),
		Transform{
			position = {.1, .3, 0},
			orientation = AngleAxis(Degrees(180), Axis{1.0, 0.0, 0.0}),
			Model ([[V:\Applications\vancegroup\GOALI\Burr\Block4.ive]])
		}
	}
}
pieceTeal = Transform{
	scale = 5.0,
	Transform{
		position = {-.0895, .3, -.009},
		orientation = AngleAxis(Degrees(180), Axis{1.0, 0.0, 0.0}),
		Model ([[V:\Applications\vancegroup\GOALI\Burr\Block5.ive]])
	}
}
pieceRed = Transform{
	scale = 5.0,
	Transform{
		position = {-.36 / 4, 1.237 / 4, .0015 / 4},
		orientation = AngleAxis(Degrees(90), Axis{0.0, 1.0, 0.0}),
		Model ([[V:\Applications\vancegroup\GOALI\Burr\BaseBlock.ive]])
	}
}
local pos = {0.8, -0.453, -0.5}
deltaX = .25
deltaY = -.9
deltaZ = .12
blue = addObject{
	position = pos,
	voxelsize = 0.003,
	density = 5,
	pieceBlue,
}
yellow = addObject{
	position = pos,
	voxelsize = 0.003,
	density = 5,
	pieceYellow,
}
green = addObject{
	position = pos,
	voxelsize = 0.003,
	density = 5,
	pieceGreen,
}
purple = addObject{
	position = pos,
	voxelsize = 0.003,
	density = 5,
	piecePurple,
}
teal = addObject{
	position = pos,
	voxelsize = 0.003,
	density = 10,
	pieceTeal,
}
red = addObject{
	position = pos,
	voxelsize = 0.003,
	density = 15,
	pieceRed,
}

addAttractorForce{body1 = green, body2 = yellow, forceDist = .2, snapDist = .025, stiff = 250, }
addAttractorForce{body1 = blue, body2 = yellow, forceDist = .2, snapDist = .025, stiff = 250, }
addAttractorForce{body1 = blue, body2 = purple, forceDist = .2, snapDist = .025, stiff = 250, }
addAttractorForce{body1 = red, body2 = yellow, forceDist = .2, snapDist = .025, stiff = 250, }
addAttractorForce{body1 = teal, body2 = yellow, forceDist = .2, snapDist = .025, stiff = 250, }



omni = Manipulators.Sensable.PhantomOmni{
	name = "Omni1",
	forces = true,
	scale = 8.0,
}

left = translateManipulator{
	omni,
	translation = {0.0, 1.0, -0.5}
}

addManipulator(left)

simulation:startInSchedulerThread()