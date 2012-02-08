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

print("Loading in buttons...")
--Load in off button
OFF = Transform{
	orientation = AngleAxis(Degrees(220), Axis{1.0, 0.0, 0.0}),
	Transform{
		scale = 1.5,
		orientation = AngleAxis(Degrees(90), Axis{0.0, 1.0, 0.0}),
		Model(".././OnOff-Button/onbutton.ive")
	}
}
--Load in on button
ON = Transform{
	orientation = AngleAxis(Degrees(220), Axis{1.0, 0.0, 0.0}),
	Transform{
		scale = 1.5,
		orientation = AngleAxis(Degrees(90), Axis{0.0, 1.0, 0.0}),
		Model(".././OnOff-Button/offbutton.ive")
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

function setButtonTransparencyON()
	trans_switch:setValue(1,true)
	trans_switch:setValue(0,false)
end

function setButtonTransparencyOFF()
	trans_switch:setValue(1,false)
	trans_switch:setValue(0,true)
end

function setButtonModelON()
	button_Switch:setValue(1,true)
	button_Switch:setValue(0,false)
end

function setButtonModelOFF()
	button_Switch:setValue(1,false)
	button_Switch:setValue(0,true)
end

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

function returnButtonPosition()
	if domHand == "right" then
		print("Setting button position to left hand side.")
		local button_pos = {0.05, 1.15, -0.15}
		return button_pos
	else
		print("Setting button position to right hand side.")
		local button_pos = {0.65, 1.15, -0.15}
		return button_pos
	end
end

buttonXForm = Transform{
	position = returnButtonPosition(),
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
		if omni:getButtonState(1) and lastButtonState2 == false then
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
	if domHand == "right" then
		right_hand = buttonDistanceCheck(buttonXForm, omni, getTransformForVPSBody(omni):getChild(0), myRadius)
		left_hand = gloveDistCheck(buttonXForm, glove, getTransformForVPSBody(glove):getChild(0), myRadius)
	else
		left_hand = buttonDistanceCheck(buttonXForm, omni, getTransformForVPSBody(omni):getChild(0), myRadius)
		right_hand = gloveDistCheck(buttonXForm, glove, getTransformForVPSBody(glove):getChild(0), myRadius)
	end
	--XOR
	if (right_hand and not left_hand) or (left_hand and not right_hand) then
		return true
	else
		return false
	end
end

local lastButtonState = false
function UserAddRemove()
	if omni:getButtonState(1) and omni.hovering and lastButtonState == false then
		lastButtonState = true
		return omni:getHover()
	elseif not omni:getButtonState(1) then
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