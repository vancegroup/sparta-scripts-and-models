
-- acceptable for a stiffness of 300 N/m
partDensity = partDensity or 20
voxSize = 0.003
bracketModelScale = bracketModelScale or 0.6
ubracket = addObject{
	voxelsize = voxSize,
	position = {1.4, 1.2, 0.5},
	density = partDensity,
	Transform{
		Model("models/ry189181-2/UBracket_0.jt.osg"),
		scale = bracketModelScale
	}
}


flange = addObject{
	voxelsize = voxSize,
	position = {1.7, 1.2, 0.5},
	density = partDensity,
	Transform{
		Model("models/ry189181-2/Flange_1.jt.osg"),
		scale = bracketModelScale
	}
}


handle = addObject{
	voxelsize = voxSize,
	position = {1.8, 1.2, 0.5},
	density = partDensity,
	Transform{
		Model("models/ry189181-2/Handle_2.jt.osg"),
		scale = bracketModelScale
	}
}

rod = addObject{
	voxelsize = voxSize,
	position = {2.1, 1.2, 0.5},
	density = partDensity,
	Transform{
		Model("models/ry189181-2/Rod_3.jt.osg"),
		scale = bracketModelScale
	}
}
