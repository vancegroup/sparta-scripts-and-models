local voxSize = 0.003
local densitySize = 20

block1 = addObject{
	voxelsize = voxSize,
	position = {0.3, 1.0, -0.5},
	density = densitySize,
	Model("models/bimanual_study/block1.osg")
}
block2 = addObject{
	voxelsize = voxSize,
	position = {0.6, 1.0, -0.5},
	density = densitySize,
	Model("models/bimanual_study/block2.osg")
}