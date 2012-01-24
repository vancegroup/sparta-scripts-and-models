function runPractice()

	--Start the practice run
	voxSize = 0.003
	densitySize = 200
	scaleSize = 10.0

	block1 = addObject{
		voxelsize = voxSize,
		position = {0.0, 0.9, -0.5},
		density = densitySize,
		Transform{
			scale = scaleSize,
			Model("V:/Applications/Vances_group/GOALI/Falling Star/Block1.ive")
		}
	}
	block2 = addObject{
		voxelsize = voxSize,
		position = {0.3, 0.9, -0.5},
		density = densitySize,
		Transform{
			scale = scaleSize,
			Model("V:/Applications/Vances_group/GOALI/Falling Star/Block1.ive")
		}
	}
	block3 = addObject{
		voxelsize = voxSize,
		position = {0.6, 0.9, -0.5},
		density = densitySize,
		Transform{
			scale = scaleSize,
			Model("V:/Applications/Vances_group/GOALI/Falling Star/Block1.ive")
		}
	}
	block4 = addObject{
		voxelsize = voxSize,
		position = {0.0, 1.1, -0.5},
		density = densitySize,
		Transform{
			scale = scaleSize,
			Model("V:/Applications/Vances_group/GOALI/Falling Star/Block1.ive")
		}
	}
	block5 = addObject{
		voxelsize = voxSize,
		position = {0.3, 1.1, -0.5},
		density = densitySize,
		Transform{
			scale = scaleSize,
			Model("V:/Applications/Vances_group/GOALI/Falling Star/Block1.ive")
		}
	}
	block6 = addObject{
		voxelsize = voxSize,
		position = {0.6, 1.1, -0.5},
		density = densitySize,
		Transform{
			scale = scaleSize,
			Model("V:/Applications/Vances_group/GOALI/Falling Star/Block2.ive")
		}
	}
	block7 = addObject{
		voxelsize = voxSize,
		position = {0.0, 1.3, -0.5},
		density = densitySize,
		Transform{
			scale = scaleSize,
			Model("V:/Applications/Vances_group/GOALI/Falling Star/Block3.ive")
		}
	}
	block8 = addObject{
		voxelsize = voxSize,
		position = {0.3, 1.3, -0.5},
		density = densitySize,
		Transform{
			scale = scaleSize,
			Model("V:/Applications/Vances_group/GOALI/Falling Star/Block4.ive")
		}
	}
	block9 = addObject{
		voxelsize = voxSize,
		position = {0.6, 1.3, -0.5},
		density = densitySize,
		Transform{
			scale = scaleSize,
			Model("V:/Applications/Vances_group/GOALI/Falling Star/Block4.ive")
		}
	}


	setHelpText("Waiting to start practice...")
	print("Waiting to start practice...")

	repeat
		Actions.waitForRedraw()
	until startBtn.justPressed

	setHelpText("Twenty-minute Practice Period")
	
	SubassemblyStart()

	simulation:startInSchedulerThread()

	--20-minute trial period
	Actions.waitSeconds(5)
	--Actions.waitSeconds(60 * 20)
	simulation:waitForStop()
	
	SubassemblyStop()

	--Delete and cleanup all the pieces
	removeObject(block1)
	removeObject(block2)
	removeObject(block3)
	removeObject(block4)
	removeObject(block5)
	removeObject(block6)
	removeObject(block7)
	removeObject(block8)
	removeObject(block9)

	print("Finished with practice.")
	setHelpText("Finished with Practice")
	Actions.waitSeconds(3)

end