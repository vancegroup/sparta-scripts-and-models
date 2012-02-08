local voxSize = 0.003
local densitySize = 20
local scaleSize = 4.0

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
