require "AddAppDirectory"
AddAppDirectory()

-- Scale huge for the video
--relativeScale = 1.0

-- Scale smaller for a demo
relativeScale = .8


bracketModelScale = 0.6 * relativeScale
partDensity = 20 / relativeScale

runfile("../simparams.lua")
runfile("../UBracket/bracket_models.lua")
runfile("../Devices/METaL Haption New Bubble.lua")
runfile("../start-sim.lua")