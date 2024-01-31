local objects = require("objects")

local screen = {}

local world = nil
local character = nil
local floor = nil

function screen:Load(ScreenManager)
	love.graphics.setBackgroundColor(0,0,0,0)
	love.keyboard.setKeyRepeat(true)

	world = love.physics.newWorld( 0, 9.8, false )
	character = objects.Character.new(world, love.graphics.getWidth()/2, love.graphics.getHeight()/2)
	floor = objects.Floor.new(world, 0, love.graphics.getHeight()-50/2, love.graphics.getWidth(), 50)
end

function screen:Update( dt )
	world:update(dt)
end

function screen:Draw()
	floor:draw()
	character:draw()
end

function screen:Quit()
	love.event.quit()
end

return screen

