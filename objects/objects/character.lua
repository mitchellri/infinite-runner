local constants = require("constants")
local base = require("objects/base/character")

local character = {}

function character.new(world, x, y)
	local o = setmetatable({}, {__index = base}) -- Create a new object - When an index isn't found in the object, look at Base.Character
	
	o.body = love.physics.newBody( world, x, y, "dynamic")
	o.body:setFixedRotation(true)
	--[[
		The origin of a circle "shape" is at the top left (as if it were a rectangle)
		The top left of the circle "shape" is at the origin of the "body" (0, 0) locally without translating it
	]]
	local shape = love.physics.newCircleShape( 0, 0, o.radius ) -- Shape is copied not referenced - can retrieve shape via fixture:getShape
	o.fixture = love.physics.newFixture( o.body, shape, 1 )
	o.fixture:setUserData(o) -- Set the data that gets passed when a collision is detected (Required for collision detection)
	
	return o
end

return character