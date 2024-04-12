local background = require("backGround")
local objects = require("objects")

local screen = {
	isPaused = false,
	onPlayerDeath = nil
}

local world = nil
local character = nil
local floor = nil
local rock = nil

--[[ Collision ]]
local function beginContact(a, b, col)
	a = a:getUserData()
	b = b:getUserData()
	a:beginContact(b, col)
	b:beginContact(a, col)
end
local function endContact(a, b, col)
	a = a:getUserData()
	b = b:getUserData()
	a:endContact(b, col)
	b:endContact(a, col)
end
local function preSolve(a, b, col)
	a = a:getUserData()
	b = b:getUserData()
	a:preSolve(b, col)
	b:preSolve(a, col)
end
local function postSolve(a, b, col, normalImpulse, tangentImpulse)
	a = a:getUserData()
	b = b:getUserData()
	a:postSolve(b, col, normalImpulse, tangentImpulse)
	b:postSolve(a, col, normalImpulse, tangentImpulse)
end
--[[ /Collision ]]

local function onPlayerDeath()
	if screen.onPlayerDeath ~= nil then
		screen:onPlayerDeath()
	end
end

function screen:load(ScreenManager)
	love.graphics.setBackgroundColor(0,0,0,0)
	love.keyboard.setKeyRepeat(true)

	self.isPaused = false
	self.onPlayerDeath = nil

	world = love.physics.newWorld( 0, 9.8*4 * love.physics.getMeter(), false )
	world:setCallbacks(beginContact, endContact, preSolve, postSolve)
	character = objects.Character.new(world, love.graphics.getWidth()/2, love.graphics.getHeight()/2)
	character.onDeath = onPlayerDeath
	floor = objects.Floor.new(world, 0, love.graphics.getHeight()-50/2, love.graphics.getWidth(), 50)
	rock = objects.Rock.new(world, love.graphics.getWidth() - 75, floor.body:getY() - 61)
	background:load()
end

function screen:update( dt )
	if not self.isPaused then
		world:update(dt)
		character:update(dt)
		background:update(dt)
		objects.Speed = background.background_speed
		rock:update(dt)
	end
end

function screen:draw()
	background:draw()
	floor:draw()
	rock:draw()
	character:draw()
end

function screen:pause(newPaused)
	self.isPaused = newPaused
end


function screen:keypressed( key )
	character:keypressed( key )
end
return screen