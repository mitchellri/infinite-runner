local rectangle = require("objects/base/rectangle")

local floor = {}

function floor.new(world, x, y, width, height)
	local o = setmetatable({}, {__index = rectangle}) -- Create a new object - When an index isn't found in the object, look at Base.Rectangle
	o.width = width
	o.height = height

	o.body = love.physics.newBody( world, x, y, "static")
	--[[
		The origin of a rectangle "shape" is at the center
		Move the rectangle "shape" so the top left of the rectangle "shape" is at the origin of the "body" (0, 0) locally
	]]
	local shape = love.physics.newRectangleShape( o.width/2, o.height/2, o.width, o.height, 0 )
	o.fixture = love.physics.newFixture( o.body, shape, 1 ) -- Shape is copied not referenced
	o.fixture:setUserData(o) -- Set the data that gets passed when a collision is detected (Required for collision detection)
	
	return o
end

return floor