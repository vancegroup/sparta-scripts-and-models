params = defineSimulationParameters{
	--This is a good parameter for the omnis
	maxStiffness = 300.0,
	parts = 4
}

require("getScriptFilename")
vrjLua.appendToModelSearchPath(getScriptFilename())

function runfile(fn)
	dofile(vrjLua.findInModelSearchPath(fn))
end

require("Actions")

-- Pick the button for switching
startBtn = gadget.DigitalInterface("VJButton0")

--load in pieces
runfile("load_models.lua")
--add device functions
runfile("setup_devices.lua")

function turnOffForces()
	if handedness == "right" then
		right.forces = false
	else
		left.forces = false
	end
end

function turnOnForces()
	if handedness == "right" then
		right.forces = true
	else
		left.forces = true
	end
end

Actions.addFrameAction(
	function(dt)
		while true do
			--Single Omni, no haptics
			repeat
				Actions.waitForRedraw()
			until startBtn.justPressed
			simulation:runFunctionWithSimulationPaused(turnOffForces)
			--Single Omni, haptics
			repeat
				Actions.waitForRedraw()
			until startBtn.justPressed
			simulation:runFunctionWithSimulationPaused(turnOnForces)
			--Omni (w/haptics) and Glove
			repeat
				Actions.waitForRedraw()
			until startBtn.justPressed
		end
	end
)--End action

simulation:startInSchedulerThread()