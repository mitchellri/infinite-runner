local objects = require("objects")

local screen = {
	isPaused = false
}

local world = nil
local character = nil
local floor = nil

function screen:load(ScreenManager)
	love.graphics.setBackgroundColor(0,0,0,0)
	love.keyboard.setKeyRepeat(true)

	self.isPaused = false

	world = love.physics.newWorld( 0, 9.8*4 * love.physics.getMeter(), false )
	character = objects.Character.new(world, love.graphics.getWidth()/2, love.graphics.getHeight()/2)
	floor = objects.Floor.new(world, 0, love.graphics.getHeight()-50/2, love.graphics.getWidth(), 50)
end

function screen:update( dt )
	if not self.isPaused then
		world:update(dt)
		character:update(dt)
	end
end

function screen:draw()
	floor:draw()
	character:draw()
end

function screen:pause(newPaused)
	self.isPaused = newPaused
end


function screen:keypressed( key )
	character:keypressed( key )
end
return screen