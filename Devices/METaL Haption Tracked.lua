virtuose = Devices.Haption.Virtuose6D3545{
	--ipaddress = "192.168.1.13",
	ipaddress = "127.0.0.1:3131#5002",
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

translated = translateDevice{
	tracked,		
	translation = {0, 0.5, 0.3}
}

addDevice(
	translated
)
