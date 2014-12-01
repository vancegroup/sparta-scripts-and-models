virtuose = Devices.Haption.Virtuose6D3545{
	ipaddress = "127.0.0.1:3131#5002",
	scale = 1.0,
	hardwareForceScale = 1.0,
	torqueScale = 1.0,
	forces = true,
	indexType = "INDEXING_NONE"
}


remote = VRPNRemoteBase(virtuose, 0, 0.55, "Robot@localhost")

-- you can run the following command (and similar ones) to change the computer-side gain at runtime.
remote.gain = 1

tracked = TrackedTransform(
	remote,
	"HaptionBase",
	false
)

translated = translateDevice{
	tracked,		
	translation = {0, 0.5, 0.3}
}

--addDevice(remote)
addDevice(
	translated
)

simulation:startInSchedulerThread()

print("Simulation started!")

local pos = {
	["Raw"] = virtuose;
	["Tracked"] = tracked;
	["Translated"] = translated;
}

showPositions = function()
	print("showPositions() called:")
	for name, dev in pairs(pos) do
		print(name .. ":", dev.matrix:getTrans())
	end
end

showPositions()