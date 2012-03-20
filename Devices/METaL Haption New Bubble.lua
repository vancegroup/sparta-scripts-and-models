
nav = Navigation()

bubble = BubbleNav{
	bubble = TranslationalBubble(
		0.15, --radius
		100, -- stiffness
		1, -- velocity scale
		TranslationalBubble.PeakRingVelocity),
	manipulator = Manipulators.Haption.Virtuose6D3545{
		ipaddress = "192.168.1.13",
		scale = 1.0,
		hardwareForceScale = 1.0,
		torqueScale = 1.0,
		forces = true,
		indexType = "INDEXING_NONE"
	},
	position = {0.5, 0.5, 0.5}, -- starting position for bubble
	elasticForce = true,
	deviceCenter = {0, 0.01678, 0.6},
	showBubble = false,
	wireframeBubble = true,
	navigate = true,
	navigator = nav
}

addManipulator(nav:transformManipulator(bubble))
