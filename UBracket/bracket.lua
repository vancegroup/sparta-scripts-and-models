defineSimulationParameters{
	maxStiffness = 300.0
}

require("getScriptFilename")
vrjLua.appendToModelSearchPath(getScriptFilename())

function runfile(fn)
	dofile(vrjLua.findInModelSearchPath(fn))
end

runfile("bracket_models.lua")

simulation:startInSchedulerThread()