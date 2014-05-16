-- require("getScriptFilename")
-- vrjLua.appendToModelSearchPath(getScriptFilename())
require "AddAppDirectory"
AddAppDirectory()
params = defineSimulationParameters{
	maxStiffness = 300.0
}
--devices - "dualomni" or "gloveomni" should be passed in via launcher
--handedness - "left" or "right" should be passed in via launcher
dofile(vrjLua.findInModelSearchPath("load_devices.lua"))

local scale = 5.0

--These Burr2 puzzle pieces have the default location of the original
--Sketchup model to be in the correct position and orientation for the origin
--as well as in an assembled state.
Red = Transform{
	scale = scale,
	Model("../BlockPuzzle-Burr/Models/ive/Block1.ive")
}
Blue = Transform{
	scale = scale,
	Model("../BlockPuzzle-Burr/Models/ive/Block2.ive")
}
LightBlue = Transform{
	scale = scale,
	Model("../BlockPuzzle-Burr/Models/ive/Block3.ive")
}
Purple = Transform{
	scale = scale,
	Model("../BlockPuzzle-Burr/Models/ive/Block4.ive")
}
Green = Transform{
	scale = scale,
	Model("../BlockPuzzle-Burr/Models/ive/Block5.ive")
}
Yellow = Transform{
	scale = scale,
	Model("../BlockPuzzle-Burr/Models/ive/Block6.ive")
}

local pos = {.3, .8, -.5}

blue = addObject{
	position = pos,
	voxelsize = 0.003,
	density = 5,
	Blue,
}
yellow = addObject{
	position = pos,
	voxelsize = 0.003,
	density = 5,
	Yellow,
}
green = addObject{
	position = pos,
	voxelsize = 0.003,
	density = 5,
	Green,
}
purple = addObject{
	position = pos,
	voxelsize = 0.003,
	density = 5,
	Purple,
}
teal = addObject{
	position = pos,
	voxelsize = 0.003,
	density = 5,
	LightBlue,
}
red = addObject{
	position = pos,
	voxelsize = 0.003,
	density = 5,
	Red,
}

AttractorGroup{
	red,
	blue,
	yellow, 
	purple,
	teal,
	green,
	forceDist = .1,  		--radius at which forces begin to be applied
	snapDist = .05,  		--distance at which the part will snap into place
	stiff = 150				--force factor, how much will be applied
}

simulation:startInSchedulerThread()