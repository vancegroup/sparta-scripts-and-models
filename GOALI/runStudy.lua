function runStudy()

	print("Waiting to start study...")

	repeat
		Actions.waitForRedraw()
	until startBtn.justPressed

	simulation:startInSchedulerThread()

	local totalTime = 0
	local taskTime = 0

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

			--reset subassembly back to default empty sets
			resetSubassemblyBodies()
			
			--reset pieces back to starting point
			resetPuzzlePieces()
			--reset task time
			taskTime = 0
		end

		if totalTime > (60 * 20) then
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

	removePuzzlePieces()

	print("Study finished")

	simulation:waitForStop()

	Actions.waitSeconds(3)
end
