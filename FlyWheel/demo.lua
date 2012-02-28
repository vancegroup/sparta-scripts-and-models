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
	right.forces = false
end

function turnOnForces()
	right.forces = true
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