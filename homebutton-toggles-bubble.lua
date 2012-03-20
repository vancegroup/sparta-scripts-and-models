Actions.addFrameAction(function()
	local button = gadget.DigitalInterface("WMButtonHome")
	while true do
		repeat
			Actions.waitForRedraw()
		until button.justPressed
		hideBubble()
		repeat
			Actions.waitForRedraw()
		until button.justPressed
		showBubble()
	end
end)
