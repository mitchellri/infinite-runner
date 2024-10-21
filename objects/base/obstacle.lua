local circle = require("objects/base/circle")
local constants = require("constants")

local obstacle = setmetatable({}, {__index = circle}) -- Assign a new table, and when an index is not found in obstacle look in Base.Object
obstacle.image = love.graphics.newImage("images/objects/rock.png")
obstacle.radius = math.min(obstacle.image:getHeight(), obstacle.image:getWidth()) / 2 * constants.objects.bodyScale
obstacle.color = {0, 1, 0}
function obstacle:update(dt)
	local vx, vy = self.body:getLinearVelocity()
	self.body:setLinearVelocity(Objects.Speed, vy)
end
function obstacle:draw()
	-- Body origin is the center of the circle, animation origin is the top left of the animation
	-- Subtract radius to align with top left of the body as if it were a rectangle
	-- Add the diference between the body width and the animation
	-- This draws the center of the image at the center of the body
	-- WARNING: Rotation is not correctly accounted for in this draw
	love.graphics.draw(self.image, self.body:getX() - self.radius + (self.radius*2 - self.image:getWidth()) / 2, self.body:getY() - self.radius + (self.radius*2 - self.image:getHeight()) / 2, self.body:getAngle())
end

return obstacle