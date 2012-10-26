require "AddAppDirectory"
AddAppDirectory()

local sw = Switch{
	Model("navigation-indicator.ive")
}

local navIndicator = Transform{
	sw
}

RelativeTo.Room:addChild(navIndicator)

-- Public function - call to set the center of the nav indicator.
setNavIndicatorPos = function(location)
	navIndicator:setPosition(Vecd(location))
end

Actions.addFrameAction(function()
	local button = gadget.DigitalInterface("WMButton1")
	repeat
		Actions.waitForRedraw()
	until nav ~= nil

	while true do
		if nav.paused then
			sw:setAllChildrenOff()
		else
			sw:setAllChildrenOn()
		end
		repeat
			Actions.waitForRedraw()
		until button.justPressed
		nav.paused = not nav.paused		
	end
end)
