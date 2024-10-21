local constants = require("constants")
local obstacle = require("objects/base/obstacle")

local rock = {}

function rock.new(world, x, y)
	local o = setmetatable({}, {__index = obstacle}) -- Create a new object - When an index isn't found in the object, look at Base.Obstacle
	
	o.body = love.physics.newBody( world, x, y, "dynamic")
	o.body:setFixedRotation( true )
	--[[
		The origin of a circle "shape" is at the top left (as if it were a rectangle)
		The top left of the circle "shape" is at the origin of the "body" (0, 0) locally without translating it
	]]
	local shape = love.physics.newCircleShape( 0, 0, o.radius )
	o.fixture = love.physics.newFixture( o.body, shape, 1 ) -- Shape is copied not referenced
	o.fixture:setUserData(o) -- Set the data that gets passed when a collision is detected (Required for collision detection)

	o.type = constants.objects.type.obstacle
	
	return o
end

return rock