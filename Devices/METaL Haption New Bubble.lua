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
		newTranslation:x(),
		newTranslation:y(),
		newTranslation:z(),
		tracker.position:x(),
		tracker.position:y(),
		tracker.position:z()))
	simulation:runFunctionWithSimulationPaused(
		function()
			xlatemanip:setTranslation(newTranslation)
		end
	)
end

updateTranslate(Vec(0, 0.75, 0.3))