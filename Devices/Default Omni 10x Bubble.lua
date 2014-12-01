
omni = Devices.Sensable.PhantomOmni{
	forces = true,
	scale = 10.0 -- default is 20
}

--This is the "old" method, the new method is BubbleNav
bubble = BubbleTechnique{
	device = omni,
	radius = 0.45, -- radius of bubble in meters
	stiffness = 50.0, -- bubble stiffness
	bubbleVelocityScale = 7.0, -- default of 3.0
	position = {1.5, 1.35, 0.25}, -- starting position for bubble
	elasticForce = true,
	deviceCenter = {-0.04837, 0.4352, 0.20},
	showBubble = false,
	navigate = {true, false, true} -- navigate in x and z only
}

addDevice(bubble)
