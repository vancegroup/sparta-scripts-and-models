nav = Navigation()

virtuose = Devices.Haption.Virtuose6D3545{
	--ipaddress = "192.168.1.13",
	ipaddress = "127.0.0.1:3131#5002",
	scale = 1.0,
	hardwareForceScale = 1.0,
	torqueScale = 1.0,
	forces = true,
	indexType = "INDEXING_NONE"
}

bubble = BubbleNav{
	bubble = TranslationalBubble(
		0.22, --radius
		150, -- stiffness
		1, -- velocity scale
		TranslationalBubble.PeakRingVelocity),
	manipulator = virtuose,
	position = {0.0, 0.0, 0.0}, -- starting position for bubble
	elasticForce = true,
	deviceCenter = {0, 0.0, 0.55},
	showBubble = false,
	wireframeBubble = true,
	navigate = true,
	navigator = nav,
	lockedToFloor = true
}

xlatemanip = translateDevice{
	TrackedTransform(
		nav:transformManipulator(bubble),
		"HandTargetProxy",
		false
	),
	translation = {0, 0.5, 0.3}
}
addManipulator(xlatemanip)




showDeviceData = function()
	print("Haption Virtuose device debug data:")
	print(virtuose.debugData)
	print("User present:", virtuose.userPresent)
end

print "Call showDeviceData to show debugging information on the Virtuose device."