function runStudy()

	print("Waiting to start study...")
	setHelpText("Waiting to start study...")
	repeat
		Actions.waitForRedraw()
	until startBtn.justPressed
	
	SubassemblyStart()

	simulation:startInSchedulerThread()

	local totalTime = 0
	local taskTime = 0

	print("Waiting for 'trial complete' signal...")
	setHelpText("Trial timer running")

	while true do
		local delta = Actions.waitForRedraw()
		taskTime = taskTime + delta
		totalTime = totalTime + delta
		
		if startBtn.justPressed then
			--finished assembly
			print("Study Time: " .. tostring(taskTime))
			csv:writeRow{
				Handedness = domHand,
				Time = taskTime
			}
			csv:flush()
			
			SubassemblyStop()
			--reset pieces back to starting point
			resetPuzzlePieces()
			--reset task time
			taskTime = 0
			--reset subassembly back to default empty sets
			resetSubassemblyBodies()
			SubassemblyStart()
		end
		
		if totalTime > (10) then
			--save last time to file
			print("Study Time: " .. tostring(taskTime) .. "(DidNotFinish)")
			csv:writeRow{
				Handedness = domHand,
				Time = taskTime .. "(DidNotFinish)"
			}
			csv:flush()
			
			break
		end
	end
	
	print("Study finished")
	setHelpText("Study finished")
	simulation:waitForStop()
	SubassemblyStop()
	Actions.waitSeconds(3)
end
