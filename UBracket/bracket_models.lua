
-- acceptable for a stiffness of 300 N/m
partDensity = 20
voxSize = 0.003

ubracket = addObject{
	voxelsize = voxSize,
	position = {0.0, 1.0, -0.5},
	density = partDensity,
	Transform{
		Model("models/ry189181-2/UBracket_0.jt.osg"),
		scale = 0.6
	}
}

--[[
flange = addObject{
	voxelsize = voxSize,
	position = {0.3, 1.0, -0.5},
	density = partDensity,
	Transform{
		Model("models/ry189181-2/Flange_1.jt.osg"),
		scale = 0.6
	}
}
]]

handle = addObject{
	voxelsize = voxSize,
	position = {0.6, 1.0, -0.5},
	density = partDensity,
	Transform{
		Model("models/ry189181-2/Handle_2.jt.osg"),
		scale = 0.6
	}
}

rod = addObject{
	voxelsize = voxSize,
	position = {0.9, 1.0, -0.5},
	density = partDensity,
	Transform{
		Model("models/ry189181-2/Rod_3.jt.osg"),
		scale = 0.6
	}
}
