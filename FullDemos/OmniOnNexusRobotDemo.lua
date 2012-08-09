require("getScriptFilename")
vrjLua.appendToModelSearchPath(getScriptFilename())
function runfile(fn)
	local fullpath = vrjLua.findInModelSearchPath(fn)
	if fullpath ~= "" then
		print([[Running "]] .. fullpath .. [["...]])
		dofile(fullpath)
	else
		error("Couldn't find " .. fn .. " in model search path!", 2)
	end
end

runfile("../simparams.lua")
runfile("../Devices/OmniOnRobot.lua")
runfile("../FlyWheel/load_models.lua")
runfile("../start-sim.lua")