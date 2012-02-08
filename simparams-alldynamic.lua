-- Set up simulation parameters
defineSimulationParameters{
	-- maxStiffness - set based on the device you're using:
	-- 300 is good for the omni.
	maxStiffness = 300.0,

	-- allBodiesAreDynamic - if you specify this as true,
	-- then Newton's third law is in effect. If you don't
	-- specify this, it defaults to false: object you aren't
	-- moving don't move at all
	allBodiesAreDynamic = true
}
