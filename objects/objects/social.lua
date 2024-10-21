local reward = require("objects/base/reward")

local social = {}

function social.new(world,x,y)
	local o = setmetatable({},{__index = reward})
	o.body = love.physics.newBody(world,x,y,"dynamic")
	o.body:setFixedRotation( true)
	local shape = love.physics.newCircleShape( 0, 0, o.radius )
	o.fixture = love.physics.newFixture( o.body, shape, 1 )
	o.fixture:setUserData(o)
	return o
end 

return social