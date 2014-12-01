--Left Glove - Right Omni
require "AddAppDirectory"
AddAppDirectory(true)

print "DEPRECATED: Don't use a script with two devices in it - use the two scripts, one for each device."

runfile "LeftGlove"
runfile "RightOmni"
