--The user should be setting this to the appropriate haptics-lab-jconf file location
vrjKernel.loadConfigFile("C:/Users/carlsonp/Desktop/src/haptics-lab-jconf/fishbowl/mixins/Subassembly_Keyboard.jconf")
subBtn = gadget.DigitalInterface("VJSubassembly")
print("JCONF loaded.")

function UserEnterExit()
	--wait until key is pressed to go into edit mode
	if subBtn.justPressed then
		return true
	else
		return false
	end
end

lastButtonState = false
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

function SubassemblyStart()
	print("Starting subassembly...")
	StartSubassembly(UserEnterExit, UserAddRemove)
end

function SubassemblyStop()
	print("Stopping subassembly...")
	lastButtonState = false
	StopSubassembly()
end