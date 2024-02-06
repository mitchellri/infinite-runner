local screen = {}
local game = require("screens.subscreens.GameScreenGame")
local overlay = {
	pause = require("screens.overlays.PauseOverlay")
}

local world = nil
local character = nil
local floor = nil

function screen:Load(ScreenManager)
	game:load(ScreenManager)
	overlay.pause:load(ScreenManager)
end

function screen:Update( dt )
	game:update(dt)
	overlay.pause:update()
end

function screen:Draw()
	game:draw()
	overlay.pause:draw()
end

function screen:KeyPressed(key)
	if key == "escape" then
		overlay.pause:toggle()
	end
end

function screen:Quit()
	overlay.pause:quit()
end

return screen