function runStudy()

	getTranslationString = function(transform)
		--http://lua-users.org/wiki/StringLibraryTutorial
		return "\"" .. string.gsub(tostring(transform:getMatrix():getTrans()), " ", ",") .. "\""
	end

	print("Waiting to start study...")

	repeat
		Actions.waitForRedraw()
	until startBtn.justPressed

	--since we're running at 120Hhz for stereo, this saves data every second
	local stride = 120
	local counter = 1
	csv_pos = csvwriter.new("logs/Position_" .. datetime .. ".csv")
	csv_pos.cols = {
		"Omni",
		"Glove",
		"Red",
		"Yellow",
		"Green",
		"Blue",
		"Purple",
		"Teal",
		"Time"
	}
	csv_pos:flush()

	local osgTransforms = {
		-- :getChild(0) is necessary because of what is returned
		Omni = getTransformForVPSBody(omni):getChild(0),
		Glove = getTransformForVPSBody(glove):getChild(0),
		Red = getTransformForVPSBody(baseblock):getChild(0),
		Yellow = getTransformForVPSBody(block1):getChild(0),
		Green = getTransformForVPSBody(block2):getChild(0),
		Blue = getTransformForVPSBody(block3):getChild(0),
		Purple = getTransformForVPSBody(block4):getChild(0),
		Teal = getTransformForVPSBody(block5):getChild(0),
	}

	simulation:startInSchedulerThread()

	local totalTime = 0
	local taskTime = 0

	while true do
		local delta = Actions.waitForRedraw()
		taskTime = taskTime + delta
		totalTime = totalTime + delta

		if counter % stride == 0 then
			--save position data to file
			local row = {}
			for k, transform in pairs(osgTransforms) do
				row[k] = getTranslationString(transform)
			end
			row["Time"] = "\""..tostring(totalTime).."\""
			csv_pos:writeRow(row)
			csv_pos:flush()
			counter = counter - stride
		end
		counter = counter + 1

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
