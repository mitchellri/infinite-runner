local circle = require("objects/base/circle")
local constants = require("constants")

local reward = setmetatable({}, {__index = circle}) -- Assign a new table, and when an index is not found in Base.Obstacle look in Base.Object
reward.image = love.graphics.newImage("images/objects/nuomi.jpg")
reward.radius = math.min(reward.image:getHeight(), reward.image:getWidth()) / 2 * constants.objects.bodyScale
function reward:update(dt)
	local vx, vy = self.body:getLinearVelocity()
	self.body:setLinearVelocity(Objects.Speed, vy)
end

function reward:draw()
	love.graphics.draw(self.image, self.body:getX() - self.radius + (self.radius*2 - self.image:getWidth()) / 2, self.body:getY() - self.radius + (self.radius*2 - self.image:getHeight()) / 2, self.body:getAngle())
end

return reward