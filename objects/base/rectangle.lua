local object = require("objects/base/object")

local rectangle = setmetatable({}, {__index = object}) -- Assign a new table, and when an index is not found in Base.Rectangle look in Base.Object
function rectangle:draw()
	love.graphics.setColor(self.color)
	-- Move the coordinate system origin (0, 0) to the location of the physical body
	love.graphics.translate(self.body:getX(), self.body:getY())
	-- Rotate the coordinate system (0, 0) by the rotation of the physical body
	love.graphics.rotate(self.body:getAngle()) -- body:getAngle returns the angle relative to the origin of the body

	-- Draw a regular rectangle at the now, translated and rotated coordinate system
	love.graphics.rectangle("fill",
	0,0,
	self.width,
	self.height)
	
	-- Return the coordinate system back to its default settings
	love.graphics.origin()
	love.graphics.setColor(1, 1, 1, 1)
end

return rectangle