require('/lib/AnAL')

--[[	BASE	]]
--[[
	Initializes the minimum required attributes for common objects
	Defines common unchanging logic, and static variables
]]

Base = {}

Base.Object = { -- All objects must contain these attributes
	color = {1, 1, 1, 1},
	width = 0,
	height = 0,
	body = nil,
	fixture = nil,
	draw = function() end
}

Base.Rectangle = setmetatable({}, {__index = Base.Object}) -- Assign a new table, and when an index is not found in Base.Rectangle look in Base.Object
function Base.Rectangle:draw()
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

--[[	OBJECTS	]]
--[[
	Objects to be used in the game
	This is the exported table
]]

Objects = {}
Objects.Character = {}
Objects.Floor = {}

function Objects.Character.new(world, x, y)
	local o = setmetatable({}, {__index = Base.Object}) -- Create a new object - When an index isn't found in the object, look at Base.Object
	o.scale = 5
	o.width = 21 * o.scale
	o.height = 16 * o.scale
	o.jumpVelocity = 1200/2
	o.body = love.physics.newBody( world, x, y, "dynamic")
	o.animation = {}
	o.animation.walk = newAnimation(love.graphics.newImage("images/Player/walk.png"), 21, 16, 0.1, 8)
	o.animation.current = o.animation.walk
	--[[
		The origin of rectangle is the center of the rectangle in this case
		Move the rectangle so the top left of the rectangle is at the origin of the body
	]]
	local shape = love.physics.newRectangleShape( o.width/2, o.height/2, o.width, o.height, 0 ) -- Shape is copied not referenced - can retrieve shape via fixture:getShape
	o.fixture = love.physics.newFixture( o.body, shape, 1 )

	function o:jump( )
		o.body:setLinearVelocity( 0, -o.jumpVelocity )
	end

	function o:keypressed( key )
		if(key == "j") then 
			o:jump()
		end
	end

	function o:update(dt)
		self.animation.current:update(dt)
	end

	function o:draw()
		self.animation.current:draw(self.body:getX(), self.body:getY(), self.body:getAngle(), self.scale)
	end

	return o
end


function Objects.Floor.new(world, x, y, width, height)
	local o = setmetatable({}, {__index = Base.Rectangle}) -- Create a new object - When an index isn't found in the object, look at Base.Rectangle
	o.width = width
	o.height = height
	o.color = {0, 1, 0}

	o.body = love.physics.newBody( world, x, y, "static")
	--[[
		The origin of rectangle is the center of the rectangle in this case
		Move the rectangle so the top left of the rectangle is at the origin of the body
	]]
	local shape = love.physics.newRectangleShape( o.width/2, o.height/2, o.width, o.height, 0 )
	o.fixture = love.physics.newFixture( o.body, shape, 1 ) -- Shape is copied not referenced
	
	return o
end

return Objects