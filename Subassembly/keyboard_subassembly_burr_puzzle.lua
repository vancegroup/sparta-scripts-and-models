--Keyboard subassembly implementation
require("Actions")
--The user should be setting this to the appropriate haptics-lab-jconf file location
vrjKernel.loadConfigFile("C:/Users/carlsonp/Desktop/src/haptics-lab-jconf/fishbowl/mixins/Subassembly_Keyboard.jconf")
subBtn = gadget.DigitalInterface("VJSubassembly")

params = defineSimulationParameters{
	maxStiffness = 300.0
}

voxSize = 0.003
densitySize = 20
scaleSize = 4.0

baseblock = addObject{
	voxelsize = voxSize,
	position = {0.0, 1.0, -0.5},
	density = densitySize,
	Transform{
		scale = scaleSize,
		Model("V:/Applications/Vances_group/GOALI/Burr/BaseBlock.ive")
	}
}
block1 = addObject{
	voxelsize = voxSize,
	position = {0.3, 1.0, -0.5},
	density = densitySize,
	Transform{
		scale = scaleSize,
		Model("V:/Applications/Vances_group/GOALI/Burr/Block1.ive")
	}
}
block2 = addObject{
	voxelsize = voxSize,
	position = {0.6, 1.0, -0.5},
	density = densitySize,
	Transform{
		scale = scaleSize,
		Model("V:/Applications/Vances_group/GOALI/Burr/Block2.ive")
	}
}
block3 = addObject{
	voxelsize = voxSize,
	position = {0.0, 1.2, -0.5},
	density = densitySize,
	Transform{
		scale = scaleSize,
		Model("V:/Applications/Vances_group/GOALI/Burr/Block3.ive")
	}
}
block4 = addObject{
	voxelsize = voxSize,
	position = {0.3, 1.2, -0.5},
	density = densitySize,
	Transform{
		scale = scaleSize,
		Model("V:/Applications/Vances_group/GOALI/Burr/Block4.ive")
	}
}
block5 = addObject{
	voxelsize = voxSize,
	position = {0.6, 1.2, -0.5},
	density = densitySize,
	Transform{
		scale = scaleSize,
		Model("V:/Applications/Vances_group/GOALI/Burr/Block5.ive")
	}
}

--Add Omni
manip = Manipulators.Sensable.PhantomOmni{
	name = "Omni2",
	forces = true,
	scale = 8.0
}
right = translateManipulator{
	manip,
	translation = {0.6, 1.0, -0.5}
}
addManipulator(right)
left = Manipulators.Gadgeteer.Glove{position = "LeftGlove",
	options = "USB1",
	hardware = "GloveHardware5DT",
	reportType = "KalmanFilter",  -- "KalmanFilter", "Raw", "HardwareCalibrated", "GloveToolsCalibrated"
	calibFile = "assets/calibrations/calib-left-5dt.txt",
}
addManipulator(left)

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
