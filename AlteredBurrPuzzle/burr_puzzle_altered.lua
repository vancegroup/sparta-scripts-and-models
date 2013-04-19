require("getScriptFilename")
vrjLua.appendToModelSearchPath(getScriptFilename())
params = defineSimulationParameters{
	maxStiffness = 300.0
}
--devices - "dualomni" or "gloveomni" should be passed in via launcher
--handedness - "left" or "right" should be passed in via launcher
dofile(vrjLua.findInModelSearchPath("load_devices.lua"))

local function changeTransformColor(xform, color)
	local mat = osg.Material()
	mat:setColorMode(0x1201);
	mat:setAmbient (0x0408, osg.Vec4(color[1], color[2], color[3], 1.0))
	mat:setDiffuse (0x0408, osg.Vec4(0.2, 0.2, 0.2, 1.0))
	mat:setSpecular(0x0408, osg.Vec4(0.2, 0.2, 0.2, 1.0))
	mat:setShininess(0x0408, 1)
	local ss = xform:getOrCreateStateSet()
	ss:setAttributeAndModes(mat, osg.StateAttribute.Values.ON+osg.StateAttribute.Values.OVERRIDE);
end


local scale = 5.0

Red = Transform{
	scale = scale,
	Model([[../models/Part1.osg]])
}
changeTransformColor(Red,{153/255,0/255,0/255})

Blue = Transform{
	scale = scale,
	Model([[../models/Part2.osg]])
}
changeTransformColor(Blue,{0/255,0/255,204/255})

LightBlue = Transform{
	scale = scale,
	Model([[../models/Part3.osg]])
}
changeTransformColor(LightBlue,{0/255,153/255,153/255})

Purple = Transform{
	scale = scale,
	Model([[../models/Part4.osg]])
}
changeTransformColor(Purple,{76/255,0/255,153/255})

Green = Transform{
	scale = scale,
	Model([[../models/Part5.osg]])
}
changeTransformColor(Green,{0/255,153/255,0/255})

Yellow = Transform{
	scale = scale,
	Model([[../models/Part6.osg]])
}
changeTransformColor(Yellow,{204/255,204/255,0/255})


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

-- AttractorGroup{
	-- red,
	-- blue,
	-- yellow, 
	-- purple,
	-- teal,
	-- green,
	-- forceDist = .1,  		--radius at which forces begin to be applied
	-- snapDist = .05,  		--distance at which the part will snap into place
	-- stiff = 150				--force factor, how much will be applied
-- }

simulation:startInSchedulerThread()