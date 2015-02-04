nav = Navigation()

wand = Devices.Gadgeteer.Wand{position = "VJWand"}
bubble = BubbleNav{
	bubble = TranslationalBubble(
		1, --radius
		100, -- stiffness
		15, -- velocity scale
		TranslationalBubble.QuadraticVelocity),
	device = wand,
	elasticForce = true,
	deviceCenter = {2.25, 1.0, 1.5},
	showBubble = true,
	lockedToFloor = true,
	navigate = true,
	navigator = nav,
}
addDevice(nav:transformDevice(bubble))
