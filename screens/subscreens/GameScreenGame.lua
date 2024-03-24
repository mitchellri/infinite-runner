local background = require("backGround")
local objects = require("objects")

local screen = {
	isPaused = false
}

local world = nil
local character = nil
local floor = nil
local rock = nil

function screen:load(ScreenManager)
	love.graphics.setBackgroundColor(0,0,0,0)
	love.keyboard.setKeyRepeat(true)

	self.isPaused = false

	world = love.physics.newWorld( 0, 9.8 * love.physics.getMeter(), false )
	character = objects.Character.new(world, love.graphics.getWidth()/2, love.graphics.getHeight()/2)
	floor = objects.Floor.new(world, 0, love.graphics.getHeight()-50/2, love.graphics.getWidth(), 50)
	rock = objects.Rock.new(world, love.graphics.getWidth() - 75, floor.body:getY() - 61)
end

function screen:update( dt )
	if not self.isPaused then
		world:update(dt)
		rock:update(dt)
		background:update(dt)
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