function runPractice()

	--Start the practice run
	voxSize = 0.003
	densitySize = 20
	scaleSize = 1.0

	block1 = addObject{
		voxelsize = voxSize,
		position = {0.05, 0.9, -0.5},
		density = densitySize,
		Transform{
			scale = scaleSize,
			Model("Models/Blocks/block1.osg")
		}
	}
	block2 = addObject{
		voxelsize = voxSize,
		position = {0.35, 0.9, -0.5},
		density = densitySize,
		Transform{
			scale = scaleSize,
			Model("Models/Blocks/block1.osg")
		}
	}
	block3 = addObject{
		voxelsize = voxSize,
		position = {0.65, 0.9, -0.5},
		density = densitySize,
		Transform{
			scale = scaleSize,
			Model("Models/Blocks/block1.osg")
		}
	}
	block4 = addObject{
		voxelsize = voxSize,
		position = {0.05, 1.1, -0.5},
		density = densitySize,
		Transform{
			scale = scaleSize,
			Model("Models/Blocks/block2.osg")
		}
	}
	block5 = addObject{
		voxelsize = voxSize,
		position = {0.35, 1.1, -0.5},
		density = densitySize,
		Transform{
			scale = scaleSize,
			Model("Models/Blocks/block2.osg")
		}
	}
	block6 = addObject{
		voxelsize = voxSize,
		position = {0.65, 1.1, -0.5},
		density = densitySize,
		Transform{
			scale = scaleSize,
			Model("Models/Blocks/block2.osg")
		}
	}

	print("Waiting to start practice...")

	repeat
		Actions.waitForRedraw()
	until startBtn.justPressed

	simulation:startInSchedulerThread()

	--10-minute trial period
	--Actions.waitSeconds(5)
	Actions.waitSeconds(60 * 10)
	simulation:waitForStop()

	resetSubassemblyBodies()

	--Delete and cleanup all the pieces
	removeObject(block1)
	removeObject(block2)
	removeObject(block3)
	removeObject(block4)
	removeObject(block5)
	removeObject(block6)

	print("Finished with practice.")

	Actions.waitSeconds(3)

end