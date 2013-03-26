require("getScriptFilename")
vrjLua.appendToModelSearchPath(getScriptFilename())

runfile("../Devices/METaL Haption on Robot.lua")
runfile("../UBracket/bracket_models.lua")
runfile("../start-sim.lua")