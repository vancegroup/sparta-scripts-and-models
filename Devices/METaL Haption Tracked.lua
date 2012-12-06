virtuose = Manipulators.Haption.Virtuose6D3545{
	ipaddress = "192.168.1.13",
	scale = 1.0,
	hardwareForceScale = 1.0,
	torqueScale = 1.0,
	forces = true,
	indexType = "INDEXING_NONE"
}

tracked = TrackedTransform(
	virtuose,
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
