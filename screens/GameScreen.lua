local screen = {}
local game = require("screens.subscreens.GameScreenGame")
local overlay = {
	pause = require("screens.overlays.PauseOverlay")
}

local function onPauseClose()
	game:pause(false)
end

overlay.pause.onClose = onPauseClose

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
		if overlay.pause.isActive then game:pause(true) end -- Don't pause the game when toggling off the pause menu
	end
end

function screen:Quit()
	overlay.pause:quit()
end

return screen