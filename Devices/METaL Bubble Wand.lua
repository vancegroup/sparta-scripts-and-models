
wand = Manipulators.Gadgeteer.Wand{position = "VJWand"}
bubble = BubbleTechnique{
	manipulator = wand,
	radius = .875, -- radius of bubble in meters
	stiffness = 100.0, -- bubble stiffness
	bubbleVelocityScale = 50.0, -- default of 3.0
	position = {2, 0, 1.5}, -- starting position for bubble
	elasticForce = true,
	deviceCenter =  {2, 1.5, 1.5},
	showBubble = true,
	navigate = {true, false, true} -- navigate in x and z only
}
addManipulator(bubble)

simulation:startInSchedulerThread()