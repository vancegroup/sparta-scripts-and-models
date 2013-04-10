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
		Model(".././OnOff-Button/onbutton.ive"),
	}
}
--Load in on button
ON = Transform{
	orientation = AngleAxis(Degrees(220), Axis{1.0, 0.0, 0.0}),
	Transform{
		scale = 1.5,
		orientation = AngleAxis(Degrees(90), Axis{0.0, 1.0, 0.0}),
		Model(".././OnOff-Button/offbutton.ive"),
	}
}
--which button to display - default to OFF (0, true)
local button_Switch = osg.Switch()
button_Switch:addChild(OFF)
button_Switch:addChild(ON)
button_Switch:setValue(0, true)
button_Switch:setValue(1, false)

--transparent group
local TransXform = osg.Group()
makeTransparent(TransXform)
TransXform:addChild(button_Switch)

--show transparent or normal?
local trans_switch = osg.Switch()
trans_switch:addChild(button_Switch)
trans_switch:addChild(TransXform)
trans_switch:setSingleChildOn(0)

function setButtonTransparencyON()
	trans_switch:setSingleChildOn(1)
end

function setButtonTransparencyOFF()
	trans_switch:setSingleChildOn(0)
end

function setButtonModelON()
	button_Switch:setSingleChildOn(1)
end

function setButtonModelOFF()
	button_Switch:setSingleChildOn(0)
end


local buttonXForm = Transform{
	position = {0.0, 0.8, -0.4},
	trans_switch,
}
RelativeTo.World:addChild(buttonXForm)


local lastButtonState2 = false
local gloveInProximity = false
buttonstate = "OFF"

function buttonDistanceCheck(buttonXForm, manip, manip_osg, radius)
	local distance = (manip_osg:getMatrix():getTrans() - buttonXForm:getPosition()):length()
	if distance < radius then
		setButtonTransparencyON()
		if manip:getButtonState(1) and lastButtonState2 == false then
			if buttonstate == "OFF" then
				buttonstate = "ON"
				setButtonModelON()
			else
				buttonstate = "OFF"
				setButtonModelOFF()
			end
			lastButtonState2 = true
			return true
		end
	else
		setButtonTransparencyOFF()
		return false
	end
	lastButtonState2 = false
	return false
end

function gloveDistCheck(buttonXForm, manip, manip_osg, radius)
	local distance = (manip_osg:getMatrix():getTrans() - buttonXForm:getPosition()):length()
	if distance < radius then
		setButtonTransparencyON()
		if gloveInProximity == false then
			gloveInProximity = true
		end
		return false
	else
		if gloveInProximity == true then
			setButtonTransparencyOFF()
			gloveInProximity = false
			if buttonstate == "OFF" then
				buttonstate = "ON"
				setButtonModelON()
			else
				buttonstate = "OFF"
				setButtonModelOFF()
			end
			return true
		else
			return false
		end
	end
end

local myRadius = buttonXForm:computeBound():radius()
function UserEnterExit()
	local rightdevice = nil
	local leftdevice = nil
	if devices == "gloveomni" then
		if handedness == "right" then
			rightdevice = buttonDistanceCheck(buttonXForm, right, getTransformNodeForCoordinateFrame(right):getChild(0), myRadius)
			leftdevice = gloveDistCheck(buttonXForm, left, getTransformNodeForCoordinateFrame(left):getChild(0), myRadius)
		elseif handedness == "left" then
			rightdevice = gloveDistCheck(buttonXForm, right, getTransformNodeForCoordinateFrame(right):getChild(0), myRadius)
			leftdevice = buttonDistanceCheck(buttonXForm, left, getTransformNodeForCoordinateFrame(left):getChild(0), myRadius)
		end
	elseif devices == "dualomni" then
		rightdevice = buttonDistanceCheck(buttonXForm, right, getTransformNodeForCoordinateFrame(right):getChild(0), myRadius)
		leftdevice = buttonDistanceCheck(buttonXForm, left, getTransformNodeForCoordinateFrame(left):getChild(0), myRadius)
	end
	--XOR
	if (rightdevice and not leftdevice) or (leftdevice and not rightdevice) then
		return true
	else
		return false
	end
end

local lastButtonState = false
function UserAddRemove(manip)
	local function f()
		if manip:getButtonState(1) and manip.hovering and lastButtonState == false then
			lastButtonState = true
			return manip:getHover()
		elseif not manip:getButtonState(1) then
			lastButtonState = false
			return false
		else
			return false
		end
	end
	return f
end

--This defines graphically what will change when items
--are added/removed from the subassembly.
local GraphicsNode = osgFX.Scribe()
GraphicsNode:setWireframeLineWidth(20)

--begin subassembly
if handedness == "right" then
	StartSubassembly(UserEnterExit, UserAddRemove(right), GraphicsNode)
else
	StartSubassembly(UserEnterExit, UserAddRemove(left), GraphicsNode)
end

simulation:startInSchedulerThread()
