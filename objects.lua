require('/lib/AnAL')

local bodyScale = 0.95 -- Generally we want the collidable area to be smaller than what we see, to avoid frustration when playing

--[[	TYPE	]]
Type = {
	obstacle = 1
}

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
	draw = function() end,
	beginContact = function(object, col) end,
	endContact = function(object, col) end,
	preSolve = function(object, col) end,
	postSolve = function(object, col, normalImpulse, tangentImpulse) end
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

Base.Circle = setmetatable({}, {__index = Base.Object}) -- Assign a new table, and when an index is not found in Base.Circle look in Base.Object
function Base.Circle:draw()
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

Base.Obstacle = setmetatable({}, {__index = Base.Circle}) -- Assign a new table, and when an index is not found in Base.Obstacle look in Base.Object
Base.Obstacle.image = love.graphics.newImage("images/objects/rock.png")
Base.Obstacle.radius = math.min(Base.Obstacle.image:getHeight(), Base.Obstacle.image:getWidth()) / 2 * bodyScale
Base.Obstacle.color = {0, 1, 0}
function Base.Obstacle:update(dt)
	local vx, vy = self.body:getLinearVelocity()
	self.body:setLinearVelocity(Objects.Speed, vy)
end
function Base.Obstacle:draw()
	-- Body origin is the center of the circle, animation origin is the top left of the animation
	-- Subtract radius to align with top left of the body as if it were a rectangle
	-- Add the diference between the body width and the animation
	-- This draws the center of the image at the center of the body
	-- WARNING: Rotation is not correctly accounted for in this draw
	love.graphics.draw(self.image, self.body:getX() - self.radius + (self.radius*2 - self.image:getWidth()) / 2, self.body:getY() - self.radius + (self.radius*2 - self.image:getHeight()) / 2, self.body:getAngle())
end

--Reward base
Base.Reward = setmetatable({}, {__index = Base.Circle}) -- Assign a new table, and when an index is not found in Base.Obstacle look in Base.Object
Base.Reward.image = love.graphics.newImage("images/objects/nuomi.jpg")
Base.Reward.radius = math.min(Base.Reward.image:getHeight(), Base.Reward.image:getWidth()) / 2 * bodyScale
Base.Reward.points = 0

function Base.Reward:update(dt)
	local vx, vy = self.body:getLinearVelocity()
	self.body:setLinearVelocity(Objects.Speed, vy)
end

function Base.Reward:draw()
	love.graphics.draw(self.image, self.body:getX() - self.radius + (self.radius*2 - self.image:getWidth()) / 2, self.body:getY() - self.radius + (self.radius*2 - self.image:getHeight()) / 2, self.body:getAngle())
end

function Base.Reward:consume()
	return self.points
end


--[[	OBJECTS	]]
--[[
	Objects to be used in the game
	This is the exported table
]]

Objects = {}
Objects.Speed = 0
Objects.Character = {}
Objects.Floor = {}
Objects.Rock = {}
Objects.Social = {}

function Objects.Character.new(world, x, y)
	local o = setmetatable({}, {__index = Base.Object}) -- Create a new object - When an index isn't found in the object, look at Base.Object
	o.animation = {
		walk = newAnimation(love.graphics.newImage("images/Player/walk.png"), 21, 16, 0.1, 8),
		jump = newAnimation(love.graphics.newImage("images/Player/jump.png"), 22, 18, 0.05, 4),
		land = newAnimation(love.graphics.newImage("images/Player/land.png"), 22, 18, 0.04, 6)
	}
	o.animation.jump:setMode("once")
	o.animation.land:setMode("once")
	o.animation.current = o.animation.walk

	o.sound = {
		jump = love.audio.newSource("/sound/game/sfx_movement_jump14.wav", "static"),
	}

	o.scale = 5
	o.radius = math.min(o.animation.current:getWidth() * o.scale, o.animation.current:getHeight() * o.scale) / 2 * bodyScale
	o.jumpVelocity = 1200/2

	o.score = 0
	o.body = love.physics.newBody( world, x, y, "dynamic")
	o.body:setFixedRotation(true)
	--[[
		The origin of a circle "shape" is at the top left (as if it were a rectangle)
		The top left of the circle "shape" is at the origin of the "body" (0, 0) locally without translating it
	]]
	local shape = love.physics.newCircleShape( 0, 0, o.radius ) -- Shape is copied not referenced - can retrieve shape via fixture:getShape
	o.fixture = love.physics.newFixture( o.body, shape, 1 )
	o.fixture:setUserData(o) -- Set the data that gets passed when a collision is detected (Required for collision detection)

	o.onDeath = nil

	function o:preSolve(object, col)
		if object.fixture:getBody():getType() == "dynamic" then
			if object.type == Type.obstacle then
				self:die()
			elseif object.type == Type.reward then
				self.score = self.score + object:consume()
			end
		else -- collision with floor
			vx, vy = self.body:getLinearVelocity()
			if (self.animation.current == self.animation.jump) and vy > 0 then
				self.animation.jump:reset()
				self.animation.jump:stop()
				self.animation.land:play()
				self.animation.current = self.animation.land
			elseif (self.animation.current == self.animation.land) and not self.animation.current.playing then
				self.animation.land:reset()
				self.animation.land:stop()
				self.animation.walk:play()
				self.animation.current = self.animation.walk
			end
		end
	end

	function o:die()
		if self.onDeath ~= nil then
			self:onDeath()
		end
	end

	function o:jump( )
		self.body:setLinearVelocity( 0, -o.jumpVelocity )
		self.animation.walk:stop()
		self.animation.jump:play()
		self.animation.current = self.animation.jump
		self.sound.jump:stop()
		self.sound.jump:play()
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
		-- Body origin is the center of the circle, animation origin is the top left of the animation
		-- Subtract radius to align with top left of the body as if it were a rectangle
		-- Add the diference between the body width and the animation
		-- This draws the center of the image at the center of the body
		-- WARNING: Rotation is not correctly accounted for in this draw
		self.animation.current:draw(self.body:getX() - self.radius + (self.radius*2 - self.animation.current:getWidth() * self.scale) / 2, self.body:getY() - self.radius + (self.radius*2 - self.animation.current:getHeight() * self.scale) / 2, self.body:getAngle(), self.scale)
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
		The origin of a rectangle "shape" is at the center
		Move the rectangle "shape" so the top left of the rectangle "shape" is at the origin of the "body" (0, 0) locally
	]]
	local shape = love.physics.newRectangleShape( o.width/2, o.height/2, o.width, o.height, 0 )
	o.fixture = love.physics.newFixture( o.body, shape, 1 ) -- Shape is copied not referenced
	o.fixture:setUserData(o) -- Set the data that gets passed when a collision is detected (Required for collision detection)
	
	return o
end

function Objects.Rock.new(world, x, y)
	local o = setmetatable({}, {__index = Base.Obstacle}) -- Create a new object - When an index isn't found in the object, look at Base.Obstacle
	
	o.body = love.physics.newBody( world, x, y, "dynamic")
	o.body:setFixedRotation( true )
	--[[
		The origin of a circle "shape" is at the top left (as if it were a rectangle)
		The top left of the circle "shape" is at the origin of the "body" (0, 0) locally without translating it
	]]
	local shape = love.physics.newCircleShape( 0, 0, o.radius )
	o.fixture = love.physics.newFixture( o.body, shape, 1 ) -- Shape is copied not referenced
	o.fixture:setUserData(o) -- Set the data that gets passed when a collision is detected (Required for collision detection)

	o.type = Type.obstacle
	
	return o
end

function Objects.Social.new(world,x,y)
	local o = setmetatable({},{__index = Base.Reward})
	o.points = 300
	o.body = love.physics.newBody(world,x,y,"dynamic")
	o.body:setFixedRotation( true)
	local shape = love.physics.newCircleShape( 0, 0, o.radius )
	o.fixture = love.physics.newFixture( o.body, shape, 1 )
	o.fixture:setUserData(o)
	return o
end 

return Objects