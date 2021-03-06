
wand = Devices.Gadgeteer.Wand{position = "VJWand"}
bubble = BubbleTechnique{
	device = wand,
	radius = 1, -- radius of bubble in meters
	stiffness = 100.0, -- bubble stiffness
	bubbleVelocityScale = 15.0, -- default of 3.0
	position = {2.25, 0, 1.5}, -- starting position for bubble
	elasticForce = true,
	deviceCenter = {2.25, 1.0, 1.5},
	showBubble = true,
	lockedToFloor = true,
	navigate = {true, false, true} -- navigate in x and z only
}
addDevice(bubble)
