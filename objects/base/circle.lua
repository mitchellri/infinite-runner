local object = require("objects/base/object")

local circle = setmetatable({}, {__index = object}) -- Assign a new table, and when an index is not found in Base.Circle look in Base.Object
function circle:draw()
	love.graphics.setColor(self.color)

	-- Circle is drawn from the center, compared to rectangles which are drawn from the top left
	local shape = self.fixture:getShape()
	local cx, cy = self.body:getWorldPoints(shape:getPoint())
	-- WARNING: Rotation is not accounted for in this draw
	love.graphics.circle("fill", cx, cy, shape:getRadius())
	
	-- Return the coordinate system back to its default settings
	love.graphics.origin()
	love.graphics.setColor(1, 1, 1, 1)
end

return circle