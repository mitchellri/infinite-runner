love.graphics.setDefaultFilter("nearest","nearest")
-- game = require "game"
chr = require("character")

--scalewidth=love.graphics.getWidth()
--scaleheight=love.graphics.getHeight()

-- STATE = game

--	LOAD	--
--	Called first whenever the game loads

world = love.physics.newWorld( 0, 9.8, false )
o = chr.new(world) --o is our object
function love.load()
	--	Initial graphics
	love.graphics.setBackgroundColor(0,0,0,0)
	--love.window.setIcon(love.graphics.newImage("Images/mainFish/mainFish0000.png"):getData())
	love.keyboard.setKeyRepeat(true)
	-- STATE.load()
	-- world = love.physics.newWorld( 0, 9.8, false )
	-- o = chr.new(world) --o is our object
	-- o:draw() -- pass itself as hidden parameter 

end

--	UPDATE	--
--	Updates every change in time/frame
function love.update( dt )
	-- STATSE.update(dt)
	world:update(dt)
end

function love.draw()
	-- STATE.draw()
	-- chr.draw()
	o:draw() -- pass itself as hidden parameter 
end

--	RESIZE	--
--	Called when you want to do resizes
function love.resize( w, h )

end

--	KEYPRESSED	--
--
function love.keypressed( key, isrepeat )
	-- STATE.keypressed( key, isrepeat )
end

--	KEYRELEASED	--
--
function love.keyreleased( key )
	-- if STATE.keyreleased( ) then
		-- STATE.keyreleased( key, isrepeat )
	-- end
end

--	MOUSEPRESSED	--
--
function love.mousepressed( x, y, button )
	-- STATE.mousepressed( key, isrepeat )
end

--	MOUSERELEASED	--
--
function love.mousereleased( x, y, button )
	-- STATE.mousereleased( key, isrepeat )
end

--	QUIT	--
--	Called when exited (are you sure you want to quit?)
function love.quit()
	love.event.quit()
end

function love.move(x)
	love.move.move(x)
end


