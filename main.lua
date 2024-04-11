love.graphics.setDefaultFilter("nearest","nearest")
love.audio.setVolume(0.1)

local ScreenManager = require("/lib/Yonder").ScreenManager
local Suit = require('/lib/suit/')

function love.load()
	-- See for state keys: /lib/Yonder/ScreenManager.lua
    ScreenManager:SwitchStates("game")
end

function love.update( dt )
	ScreenManager:Update( dt )
end

function love.draw()
	ScreenManager:Draw()
	Suit.draw()
end

function love.keypressed( key, scancode, isrepeat )
	ScreenManager:KeyPressed( key )
end

function love.keyreleased( key )
	ScreenManager:KeyReleased( key )
end

function love.mousepressed( x, y, button )
	ScreenManager:MousePressed( x, y, button )
end

function love.mousereleased( x, y, button )
	ScreenManager:MouseReleased( x, y, button )
end

function love.quit()
	ScreenManager:Quit()
end

function love.mousemoved( x, y, dx, dy, istouch )
	ScreenManager:MouseMoved( x, y, dx, dy, istouch )
end