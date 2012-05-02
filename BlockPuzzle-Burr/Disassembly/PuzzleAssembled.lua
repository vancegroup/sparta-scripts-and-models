--Scripted by Adam Carlson
require("getScriptFilename")
vrjLua.appendToModelSearchPath(getScriptFilename())

Red = Transform{
	Model([[..\Models\ive\Block1.ive]])
}

Blue = Transform{
	Model([[..\Models\ive\Block2.ive]])
}

LightBlue = Transform{
	Model([[..\Models\ive\Block3.ive]])
}

Purple = Transform{
	Model([[..\Models\ive\Block4.ive]])
}
	
Green = Transform{
	Model([[..\Models\ive\Block5.ive]])
}
	
Yellow = Transform{
	Model([[..\Models\ive\Block6.ive]])
}
	
RelativeTo.World:addChild(Red)
RelativeTo.World:addChild(Blue)
RelativeTo.World:addChild(LightBlue)
RelativeTo.World:addChild(Purple)
RelativeTo.World:addChild(Green)
RelativeTo.World:addChild(Yellow)
