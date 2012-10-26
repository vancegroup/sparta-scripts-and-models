nav = Navigation()

wand = Manipulators.Gadgeteer.Wand{position = "VJWand"}
bubble = BubbleNav{
	bubble = TranslationalBubble(
		1, --radius
		100, -- stiffness
		15, -- velocity scale
		TranslationalBubble.QuadraticVelocity),
	manipulator = wand,
	elasticForce = true,
	deviceCenter = {2.25, 1.0, 1.5},
	showBubble = false,
	lockedToFloor = true,
	navigate = true,
	navigator = nav,
}
addManipulator(nav:transformManipulator(bubble))
