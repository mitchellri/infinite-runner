-- game = require "game"
objects = require("objects")

--scalewidth=love.graphics.getWidth()
--scaleheight=love.graphics.getHeight()

-- STATE = game

--	LOAD	--
--	Called first whenever the game loads

local screen = {}

world = love.physics.newWorld( 0, 9.8, false )
o = objects.Character.new(world) --o is our object //our rectangle
floor = objects.Floor.new(world)
function screen:Load(ScreenManager)
	--	Initial graphics
	love.graphics.setBackgroundColor(0,0,0,0)
	--love.window.setIcon(love.graphics.newImage("Images/mainFish/mainFish0000.png"):getData())
	love.keyboard.setKeyRepeat(true)
	-- STATE.load()
	-- world = love.physics.newWorld( 0, 9.8, false )
	-- o = objects.new(world) --o is our object
	-- o:draw() -- pass itself as hidden parameter 

end

--	UPDATE	--
--	Updates every change in time/frame
function screen:Update( dt )
	-- STATSE.update(dt)
	world:update(dt)
end

function screen:Draw()
	-- STATE.draw()
	-- objects.draw()
	floor:draw()
	o:draw() -- pass itself as hidden parameter 
	
end

--	RESIZE	--
--	Called when you want to do resizes
function screen:Resize( w, h )

end

--	KEYPRESSED	--
--
function screen:KeyPressed( key, isrepeat )
	-- STATE.keypressed( key, isrepeat )
end

--	KEYRELEASED	--
--
function screen:KeyReleased( key )
	-- if STATE.keyreleased( ) then
		-- STATE.keyreleased( key, isrepeat )
	-- end
end

--	MOUSEPRESSED	--
--
function screen:MousePressed( x, y, button )
	-- STATE.mousepressed( key, isrepeat )
end

--	MOUSERELEASED	--
--
function screen:MouseReleased( x, y, button )
	-- STATE.mousereleased( key, isrepeat )
end

--	QUIT	--
--	Called when exited (are you sure you want to quit?)
function screen:Quit()
	love.event.quit()
end

return screen

