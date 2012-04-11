require("getScriptFilename")
vrjLua.appendToModelSearchPath(getScriptFilename())
dofile(vrjLua.findInModelSearchPath([[loadOmni.lua]]))
dofile(vrjLua.findInModelSearchPath([[loadBurrPuzzle.lua]]))
dofile(vrjLua.findInModelSearchPath([[csvwriter.lua]]))
csv = csvwriter.new("collisionDataJane.csv")
csv.cols = {
	"sequence",
	"move1",
	"move2",
	"move3",
	"move4",
	"move5",
	"move6",
}
disableClang = true
local currentSequence = ""
local currentContent = {}

function writeoutRow(content)
	csv:writeRow{
		sequence = content[0],
		move1 = content[1],
		move2 = content[2],
		move3 = content[3],
		move4 = content[4],
		move5 = content[5],
		move6 = content[6],
	}
	csv:flush()
end

--create Collision Counter Objects for each puzzle piece in Scene
counters = {}
counters.blue = CollisionCounter(blue)
counters.green = CollisionCounter(green)
counters.purple = CollisionCounter(purple)
counters.yellow = CollisionCounter(yellow)
counters.red = CollisionCounter(red)
counters.teal = CollisionCounter(teal)

--add Collision Counter Objects to Simulation
simulation:addFrameTask(counters.blue)	
simulation:addFrameTask(counters.green)	
simulation:addFrameTask(counters.purple)	
simulation:addFrameTask(counters.yellow)	
simulation:addFrameTask(counters.red)	
simulation:addFrameTask(counters.teal)	


function printOutCollisions()
	if counters.blue:getNumVoxelCollisions() > 0 then
		currentSequence = currentSequence.."B"
		table.insert(currentContent,counters.blue:getNumVoxelCollisions())
	end
	if counters.green:getNumVoxelCollisions() > 0 then
		currentSequence = currentSequence.."G"
		table.insert(currentContent,counters.green:getNumVoxelCollisions())
	end
	if counters.purple:getNumVoxelCollisions() > 0 then
		currentSequence = currentSequence.."P"
		table.insert(currentContent,counters.purple:getNumVoxelCollisions())
	end
	if counters.yellow:getNumVoxelCollisions() > 0 then
		currentSequence = currentSequence.."Y"
		table.insert(currentContent,counters.yellow:getNumVoxelCollisions())
	end
	if counters.red:getNumVoxelCollisions() > 0 then
		currentSequence = currentSequence.."R"
		table.insert(currentContent,counters.red:getNumVoxelCollisions())
	end
	if counters.teal:getNumVoxelCollisions() > 0 then
		currentSequence = currentSequence.."T"
		table.insert(currentContent,counters.teal:getNumVoxelCollisions())
	end
end
function saveMatricies()
	bm = blue.matrix 
	ym = yellow.matrix
	gm = green.matrix
	pm = purple.matrix
	tm = teal.matrix
	rm = red.matrix
end

function start()
	simulation:runFunctionWithSimulationPaused(saveMatricies)
end

function resetParts()
	currentContent[0] = currentSequence
	writeoutRow(currentContent)
	blue.matrix =  bm
	yellow.matrix = ym 
	green.matrix = gm 
	purple.matrix = pm
	teal.matrix = tm 
	red.matrix = rm
	currentSequence = ""
	currentContent = {}
end



function resetCounters()
	counters.blue:resetCounter()
	counters.green:resetCounter()
	counters.purple:resetCounter()
	counters.yellow:resetCounter()
	counters.red:resetCounter()
	counters.teal:resetCounter()
end

function completeCount()
	printOutCollisions()
	resetCounters()
end

function outputResults()
	simulation:runFunctionWithSimulationPaused(completeCount)
end


Actions.addFrameAction(function()
	local outBtn = gadget.DigitalInterface("VJButton2")
	while true do
		repeat	
			Actions.waitForRedraw()
		until outBtn.justPressed
		outputResults()
	end
	csv:close()
end)

Actions.addFrameAction(function()
	local outBtn2 = gadget.DigitalInterface("VJButton1")
	while true do
		repeat	
			Actions.waitForRedraw()
		until outBtn2.justPressed
		simulation:runFunctionWithSimulationPaused(resetParts)
	end
	csv:close()
end)
	

simulation:startInSchedulerThread()


