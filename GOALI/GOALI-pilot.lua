--GOALI Pilot

require("getScriptFilename")
vrjLua.appendToModelSearchPath(getScriptFilename())

function runfile(fn)
	dofile(vrjLua.findInModelSearchPath(fn))
end


runfile("csvwriter.lua")

require("Text")
require("Actions")

params = defineSimulationParameters{
	--This is a good parameter for the omnis
	maxStiffness = 300.0,
	parts = 6
}

-- Pick the button for start/stop
startBtn = gadget.DigitalInterface("VJButton0")


--Check to make sure we got passed the configuration
if handedness == "left" then
	domHand = "left"
	nonDomHand = "right"
elseif handedness == "right" then
	domHand = "right"
	nonDomHand = "left"
else
	--Something's wrong, halt the run
	error("No/invalid configuration specified! handedness = " .. tostring(handedness))
	os.exit()
end

do
	local helpGroup = osg.Group()
	RelativeTo.World:addChild(helpGroup)
	function setHelpText(...) -- ... means a variable number of parameters
		helpGroup:removeChildren(0, helpGroup:getNumChildren())

		helpGroup:addChild(
			TextGeode{
				...,
				color = osg.Vec4(0,0.2,1.0,1.0), --blue text
				position = {-2.5, 2.3, -8},
				font = Font("DroidSansBold"),
				lineHeight = 0.45
			}
		)
	end
end

switchToMinimalRoom()

runfile("FisherYatesShuffle.lua")
-- Randomize starting positions
positions = FisherYatesShuffle{
					{0.0, 1.0, -0.5},
					{0.3, 1.0, -0.5},
					{0.6, 1.0, -0.5},
					{0.0, 1.2, -0.5},
					{0.3, 1.2, -0.5},
					{0.6, 1.2, -0.5}
				}

print("Setting up devices...")
runfile("setupDevices.lua")
print("Setting up subassembly...")
runfile("setupSubassembly.lua")

print("Running practice mode...")
runfile("runPractice.lua")
print("Loading puzzle models...")
runfile("loadPuzzleModels.lua")
print("Running study...")
runfile("runStudy.lua")

csv = csvwriter.new("logs/" .. os.date("GOALI_%b_%d_%Y_-_%H%M%S") .. ".csv")
csv.cols = {
	"Handedness",
	"Time"
}

Actions.addFrameAction(function(dt)
	runPractice()
	loadBurrPuzzle()
	runStudy()

	--Close file
	csv:close()

	shutdown()
end)--End action
