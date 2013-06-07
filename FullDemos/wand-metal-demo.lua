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
runfile("../Devices/METaL Bubble Wand Pauseable.lua")
runfile("../CarpetNavRing/wmbutton1-toggles-nav.lua")
setNavIndicatorPos(Vec(2.25, 0, 1.5))
runfile("../homebutton-toggles-bubble.lua")
runfile("../HelpMenu/HelpMenu.lua")
runfile("../start-sim.lua")