
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
			Model("Models/Burr/BaseBlock.ive")
		}
	}
	block1 = addObject{
		voxelsize = voxSize,
		position = positions[2],
		density = densitySize,
		Transform{
			scale = scaleSize,
			Model("Models/Burr/Block1.ive")
		}
	}
	block2 = addObject{
		voxelsize = voxSize,
		position = positions[3],
		density = densitySize,
		Transform{
			scale = scaleSize,
			Model("Models/Burr/Block2.ive")
		}
	}
	block3 = addObject{
		voxelsize = voxSize,
		position = positions[4],
		density = densitySize,
		Transform{
			scale = scaleSize,
			Model("Models/Burr/Block3.ive")
		}
	}
	block4 = addObject{
		voxelsize = voxSize,
		position = positions[5],
		density = densitySize,
		Transform{
			scale = scaleSize,
			Model("Models/Burr/Block4.ive")
		}
	}
	block5 = addObject{
		voxelsize = voxSize,
		position = positions[6],
		density = densitySize,
		Transform{
			scale = scaleSize,
			Model("Models/Burr/Block5.ive")
		}
	}

	resetPuzzlePieces()
end

function resetPuzzlePieces()

	local function randomOrientation(body)
		local angle = math.random(1, 360)
		local axis_x = math.random(0, 1)
		local axis_y = math.random(0, 1)
		local axis_z = math.random(0, 1)
		local quat = osg.Quat(angle, osg.Vec3d(axis_x, axis_y, axis_z))
		local new_matrix = body.matrix
		new_matrix:setRotate(quat)
		body.matrix = new_matrix
	end

	simulation:waitForStop()

	--shuffle the starting positions
	positions = FisherYatesShuffle(positions)

	baseblock:setPosition(positions[1][1], positions[1][2], positions[1][3])
	block1:setPosition(positions[2][1], positions[2][2], positions[2][3])
	block2:setPosition(positions[3][1], positions[3][2], positions[3][3])
	block3:setPosition(positions[4][1], positions[4][2], positions[4][3])
	block4:setPosition(positions[5][1], positions[5][2], positions[5][3])
	block5:setPosition(positions[6][1], positions[6][2], positions[6][3])

	randomOrientation(baseblock)
	randomOrientation(block1)
	randomOrientation(block2)
	randomOrientation(block3)
	randomOrientation(block4)
	randomOrientation(block5)

	simulation:startInSchedulerThread()
end

function removePuzzlePieces()
	--Delete and cleanup all the pieces
	removeObject(baseblock)
	removeObject(block1)
	removeObject(block2)
	removeObject(block3)
	removeObject(block4)
	removeObject(block5)
end