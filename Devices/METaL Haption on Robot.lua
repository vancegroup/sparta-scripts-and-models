virtuose = Manipulators.Haption.Virtuose6D3545{
	ipaddress = "192.168.1.13",
	scale = 1.0,
	hardwareForceScale = 1.0,
	torqueScale = 1.0,
	forces = true,
	indexType = "INDEXING_NONE"
}


remote = VRPNRemoteBase(virtuose, 0, 0.6, "Robot@localhost")

-- you can run the following command (and similar ones) to change the computer-side gain at runtime.
remote.gain = 1

tracked = TrackedTransform(
	remote,
	"HaptionBase",
	false
)

translated = translateManipulator{
	tracked,		
	translation = {0, 0.5, 0.3}
}

addManipulator(
	translated
)