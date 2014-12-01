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

local lastButtonState1 = false
local lastButtonState2 = false
local lastButtonState3 = false
local gloveInProximity = false
local buttonstate = "OFF"

function buttonDistanceCheck(buttonXForm, dev, dev_osg, radius, dev2, dev2_osg)
	--dev2 and dev2_osg are optional parameters for a second omni device
	local distance = (dev_osg:getMatrix():getTrans() - buttonXForm:getPosition()):length()

	if (dev2 ~= nil and dev2_osg ~= nil) then
		local distance2 = (dev2_osg:getMatrix():getTrans() - buttonXForm:getPosition()):length()

		if (distance < radius and distance2 > radius) or (distance > radius and distance2 < radius) then
			setButtonTransparencyON()
			if (dev:getButtonState(1) or dev2:getButtonState(1)) and lastButtonState2 == false then
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
	else
		if distance < radius then
			setButtonTransparencyON()
			if dev:getButtonState(1) and lastButtonState2 == false then
				if buttonstate == "OFF" then
					buttonstate = "ON"
					setButtonModelON()
				else
					buttonstate = "OFF"
					setButtonModelOFF()
				end
				lastButtonState2 = true
				return true
			elseif not dev:getButtonState(1) and lastButtonState2 == true then
				lastButtonState2 = false
				return false
			else
				return false
			end
		else
			setButtonTransparencyOFF()
			return false
		end
	end
end

function gloveDistCheck(buttonXForm, dev, dev_osg, radius)
	local distance = (dev_osg:getMatrix():getTrans() - buttonXForm:getPosition()):length()
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
		rightdevice = buttonDistanceCheck(buttonXForm, right, getTransformNodeForCoordinateFrame(right):getChild(0), myRadius, left, getTransformNodeForCoordinateFrame(left):getChild(0))
	end
	--XOR
	if (rightdevice and not leftdevice) or (leftdevice and not rightdevice) then
		return true
	else
		return false
	end
end

--this ensures that the button doesn't toggle between on and off repeatedly based on the frame checks

function UserAddRemove(dev,lastButtonState)
	local function f()
		if dev:getButtonState(1) and dev.hovering and lastButtonState3 == false then
			lastButtonState3 = true
			return dev:getHover()
		elseif not dev:getButtonState(1) then
			lastButtonState3 = false
			return nil
		else
			return nil
		end
	end
	return f
end

function UserAddRemove2(dev1,dev2)
	function1 = UserAddRemove(dev1,lastButtonState1)
	function2 = UserAddRemove(dev2,lastButtonState2)
	local function f()
		return function1() or function2()
	end
	return f
end

--This defines graphically what will change when items
--are added/removed from the subassembly.
local GraphicsNode = osgFX.Scribe()
GraphicsNode:setWireframeLineWidth(20)


--begin subassembly
if handedness == "right" then

	sub = Subassembly{
		EnterExitFunc = UserEnterExit,
		AddRemoveFunc = UserAddRemove(right,lastButtonState3),
		graphics_node = GraphicsNode
	}

elseif handedness == "left" then

	sub = Subassembly{
		EnterExitFunc = UserEnterExit,
		AddRemoveFunc = UserAddRemove(left,lastButtonState1),
		graphics_node = GraphicsNode
	}

elseif devices == "dualomni" then

	sub = Subassembly{
		EnterExitFunc = UserEnterExit,
		AddRemoveFunc = UserAddRemove2(right, left),
		graphics_node = GraphicsNode
	}

end

simulation:startInSchedulerThread()
