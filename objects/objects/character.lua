local constants = require("constants")
local object = require("objects/base/object")

local character = {}

function character.new(world, x, y)
	local o = setmetatable({}, {__index = object}) -- Create a new object - When an index isn't found in the object, look at Base.Object
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
	o.radius = math.min(o.animation.current:getWidth() * o.scale, o.animation.current:getHeight() * o.scale) / 2 * constants.objects.bodyScale
	o.jumpVelocity = 1200/2
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
			if object.type == constants.objects.type.obstacle then
				self:die()
			end
		else
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

return character