--GOALI Pilot

require("getScriptFilename")
vrjLua.appendToModelSearchPath(getScriptFilename())

function runfile(fn)
	dofile(vrjLua.findInModelSearchPath(fn))
end

runfile("csvwriter.lua")

require("TransparentGroup")
require("Actions")
require("osgFX")

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

switchToMinimalRoom()

runfile("FisherYatesShuffle.lua")
-- Randomize starting positions
positions = FisherYatesShuffle{
	{0.05, 0.9, -0.5},
	{0.35, 0.9, -0.5},
	{0.65, 0.9, -0.5},
	{0.05, 1.3, -0.5},
	{0.35, 1.3, -0.5},
	{0.65, 1.3, -0.5}
}

print("Setting up devices...")
runfile("setupDevices.lua")
makeGloveTransparent()
print("Making glove transparent...")
print("Setting up subassembly...")
runfile("setupSubassembly.lua")

print("Running practice mode...")
runfile("runPractice.lua")
print("Loading puzzle models...")
runfile("loadPuzzleModels.lua")
print("Running study...")
runfile("runStudy.lua")

datetime = os.date("GOALI_%b_%d_%Y_-_%H%M%S")
csv = csvwriter.new("logs/" .. datetime .. ".csv")
csv.cols = {
	"Handedness",
	"Time"
}
csv:flush()

Actions.addFrameAction(
	function(dt)
		runPractice()
		loadBurrPuzzle()
		runStudy()

		--Close file
		csv:close()

		shutdown()
	end
)--End action
