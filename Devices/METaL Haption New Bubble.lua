nav = Navigation()

virtuose = Manipulators.Haption.Virtuose6D3545{
	ipaddress = "192.168.1.13",
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
	deviceCenter = {0, 0.01678, 0.6},
	showBubble = false,
	wireframeBubble = true,
	navigate = true,
	navigator = nav,
	lockedToFloor = true
}

xlatemanip = translateManipulator{
	nav:transformManipulator(bubble),
	translation = {0,0,0}
}
addManipulator(xlatemanip)

tracker = gadget.PositionInterface("HandTargetProxy")

updateTranslate = function(vec)
	local newTranslation = tracker.position + vec
	print(("\nupdateTranslate(Vec(%f, %f, %f)) called: net translation applied is (%f, %f, %f)"):format(
		vec:x(),
		vec:y(),
		vec:z(),
		newTranslation:x(),
		newTranslation:y(),
		newTranslation:z()))
	simulation:runFunctionWithSimulationPaused(
		function()
			xlatemanip:setTranslation(newTranslation)
		end
	)
end

updateTranslate(Vec(0, 0.75, 0.3))

showDeviceData = function()
	print("Haption Virtuose device debug data:")
	print(virtuose.debugData)
	print("User present:", virtuose.userPresent)
end

print "Call showDeviceData to show debugging information on the Virtuose device."