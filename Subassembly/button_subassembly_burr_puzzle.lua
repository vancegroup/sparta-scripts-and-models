--Keyboard subassembly implementation
require("Actions")
require("osgFX")
require("getScriptFilename")
vrjLua.appendToModelSearchPath(getScriptFilename())
params = defineSimulationParameters{
	maxStiffness = 300.0
}
dofile(vrjLua.findInModelSearchPath("burr_models.lua"))
dofile(vrjLua.findInModelSearchPath("load_devices.lua"))


--used for custom button
function makeTransparent(node)
	local state = node:getOrCreateStateSet()
	state:setRenderingHint(2) -- transparent bin

	local CONSTANT_ALPHA = 0x8003
	local ONE_MINUS_CONSTANT_ALPHA = 0x8004
	local bf = osg.BlendFunc()
	bf:setFunction(CONSTANT_ALPHA, ONE_MINUS_CONSTANT_ALPHA)
	state:setAttributeAndModes(bf)

	local bc = osg.BlendColor(osg.Vec4(1.0, 1.0, 1.0, 0.3))
	state:setAttributeAndModes(bc)
	node:setStateSet(state)
end


--Load in off button
OFF = Transform{
	orientation = AngleAxis(Degrees(220), Axis{1.0, 0.0, 0.0}),
	Transform{
		scale = 1.5,
		orientation = AngleAxis(Degrees(90), Axis{0.0, 1.0, 0.0}),
		Model("C:/Users/carlsonp/Desktop/button/onbutton.ive"),
	}
}
--Load in on button
ON = Transform{
	orientation = AngleAxis(Degrees(220), Axis{1.0, 0.0, 0.0}),
	Transform{
		scale = 1.5,
		orientation = AngleAxis(Degrees(90), Axis{0.0, 1.0, 0.0}),
		Model("C:/Users/carlsonp/Desktop/button/offbutton.ive"),
	}
}
--which button to display - default to OFF (0, true)
local button_Switch = osg.Switch()
button_Switch:addChild(OFF)
button_Switch:addChild(ON)
button_Switch:setValue(0,true)
button_Switch:setValue(1,false)

--transparent group
local TransXform = osg.Group()
makeTransparent(TransXform)
TransXform:addChild(button_Switch)

--show transparent or normal?
local trans_switch = osg.Switch()
trans_switch:addChild(button_Switch)
trans_switch:addChild(TransXform)
trans_switch:setValue(0,true)
trans_switch:setValue(1,false)





function getTransformForVPSBody(coordinateFrame, node)
	if node == nil then
		node = assert(knownInView(coordinateFrame))
	end
	if node:isSameKindAs(osg.MatrixTransform()) then
		return node
	else
		return getTransformForVPSBody(coordinateFrame, node:getChild(0))
	end
end


function buttonDistanceCheck(buttonXForm, manip, manip_osg, radius)
	local distance = (manip_osg:getMatrix():getTrans() - buttonXForm:getPosition()):length()
	if distance < radius then
		--set transparency on 
		trans_switch:setValue(1,true)
		trans_switch:setValue(0,false)
		if right:getButtonState(1) and lastButtonState2 == false then
			if buttonstate == "OFF" then
				buttonstate = "ON"
				button_Switch:setValue(1,true)
				button_Switch:setValue(0,false)
			else 
				buttonstate = "OFF"
				button_Switch:setValue(1,false)
				button_Switch:setValue(0,true)
			end
			lastButtonState2 = true
			return true
		end
	else
		trans_switch:setValue(1,false)
		trans_switch:setValue(0,true)
		return false
	end
	lastButtonState2 = false
	return false
end

local myRadius = buttonXForm:computeBound():radius()
function UserEnterExit()
	condition = buttonDistanceCheck(buttonXForm,right,getTransformForVPSBody(right):getChild(0),myRadius)
	if condition then
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

--begin subassembly
StartSubassembly(UserEnterExit, UserAddRemove, GraphicsNode)

simulation:startInSchedulerThread()
