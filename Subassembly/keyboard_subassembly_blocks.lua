--Keyboard subassembly implementation
require("Actions")
require("osgFX")

require("getScriptFilename")
vrjLua.appendToModelSearchPath(getScriptFilename())

--The user should be setting this to the appropriate haptics-lab-jconf file location
vrjKernel.loadConfigFile("C:/Users/carlsonp/Desktop/src/haptics-lab-jconf/fishbowl/mixins/Subassembly_Keyboard.jconf")
subBtn = gadget.DigitalInterface("VJSubassembly")

params = defineSimulationParameters{
	maxStiffness = 300.0
}

dofile(vrjLua.findInModelSearchPath("blocks_models.lua"))

dofile(vrjLua.findInModelSearchPath("load_devices.lua"))

function UserEnterExit()
	--wait until key is pressed to go into edit mode
	if subBtn.justPressed then
		return true
	else
		return false
	end
end

local lastButtonState = false
function UserAddRemove()
	if right:getButtonState(1) and right.hovering and lastButtonState == false then
		lastButtonState = true
		return right:getHover()
	elseif not right:getButtonState(1) then
		lastButtonState = false
		return false
	else
		return false
	end
end

--This defines graphically what will change when items
--are added/removed from the subassembly.
local GraphicsNode = osgFX.Scribe()
GraphicsNode:setWireframeLineWidth(20)

StartSubassembly(UserEnterExit, UserAddRemove, GraphicsNode)

simulation:startInSchedulerThread()
