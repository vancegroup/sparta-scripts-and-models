--Keyboard subassembly implementation
require("Actions")
--The user should be setting this to the appropriate haptics-lab-jconf file location
vrjKernel.loadConfigFile("C:/Users/carlsonp/Desktop/Subassembly_Keyboard.jconf")
subBtn = gadget.DigitalInterface("VJSubassembly")

params = defineSimulationParameters{
	maxStiffness = 300.0
}

block1 = addObject{
	voxelsize = 0.003,
	position = {0.3, 0.3, 0.0},
	density = 20,
	Model("models/bimanual_study/block1.osg")
}
block2 = addObject{
	voxelsize = 0.003,
	position = {0.6, 0.3, 0.0},
	density = 20,
	Model("models/bimanual_study/block2.osg")
}

--Add Omni
right = Manipulators.Sensable.PhantomOmni{
	name = "Omni1",
	forces = true,
	scale = 4.0
}
addManipulator(right)

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

StartSubassembly(UserEnterExit, UserAddRemove)

simulation:startInSchedulerThread()
