local screen = {}
local game = require("screens.subscreens.GameScreenGame")
local overlay = {
	pause = require("screens.overlays.PauseOverlay"),
	overlay = require("screens.overlays.GameScreenOverlay")
}

local function onPauseOpen()
	game:pause(true)
	overlay.overlay.isActive = false
end

local function onPauseClose()
	game:pause(false)
	overlay.overlay.isActive = true
end

overlay.pause.onOpen = onPauseOpen
overlay.pause.onClose = onPauseClose

function screen:Load(ScreenManager)
	game:load(ScreenManager)
	overlay.pause:load(ScreenManager)
	overlay.overlay:load()
end

function screen:Update( dt )
	game:update(dt)
	overlay.pause:update()
	overlay.overlay:update(dt)
end

function screen:Draw()
	game:draw()
	overlay.pause:draw()
	overlay.overlay:draw()
end


function screen:KeyPressed(key)
	overlay.pause:keypressed(key)
	game:keypressed(key)
end

function screen:Quit()
	overlay.pause:quit()
end

return screen