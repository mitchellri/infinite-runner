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

-- [[ Main Functions ]]

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
	if not overlay.pause.isVisible then
		game:keypressed(key)
	end

	overlay.pause:keypressed(key)
end

function screen:Quit()
	overlay.pause:quit()
end

return screen