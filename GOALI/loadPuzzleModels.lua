
function loadBurrPuzzle()
	--Load in models
	voxSize = 0.003
	densitySize = 20
	scaleSize = 4.0

	baseblock = addObject{
		voxelsize = voxSize,
		position = positions[1],
		density = densitySize,
		Transform{
			scale = scaleSize,
			Model("V:/Applications/Vances_group/GOALI/Burr/BaseBlock.ive")
		}
	}
	block1 = addObject{
		voxelsize = voxSize,
		position = positions[2],
		density = densitySize,
		Transform{
			scale = scaleSize,
			Model("V:/Applications/Vances_group/GOALI/Burr/Block1.ive")
		}
	}
	block2 = addObject{
		voxelsize = voxSize,
		position = positions[3],
		density = densitySize,
		Transform{
			scale = scaleSize,
			Model("V:/Applications/Vances_group/GOALI/Burr/Block2.ive")
		}
	}
	block3 = addObject{
		voxelsize = voxSize,
		position = positions[4],
		density = densitySize,
		Transform{
			scale = scaleSize,
			Model("V:/Applications/Vances_group/GOALI/Burr/Block3.ive")
		}
	}
	block4 = addObject{
		voxelsize = voxSize,
		position = positions[5],
		density = densitySize,
		Transform{
			scale = scaleSize,
			Model("V:/Applications/Vances_group/GOALI/Burr/Block4.ive")
		}
	}
	block5 = addObject{
		voxelsize = voxSize,
		position = positions[6],
		density = densitySize,
		Transform{
			scale = scaleSize,
			Model("V:/Applications/Vances_group/GOALI/Burr/Block5.ive")
		}
	}
end

function resetPuzzlePieces()
	simulation:waitForStop()
	
	baseblock:setPosition(positions[1])
	block1:setPosition(positions[2])
	block2:setPosition(positions[3])
	block3:setPosition(positions[4])
	block4:setPosition(positions[5])
	block5:setPosition(positions[6])
	
	simulation:startInSchedulerThread()
end