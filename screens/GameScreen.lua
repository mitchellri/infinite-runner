local screen = {}
local game = require("screens.subscreens.GameScreenGame")
local overlay = { -- Overlays only using Suit do not need to have draw() called
	pause = require("screens.overlays.PauseOverlay"),
	overlay = require("screens.overlays.GameScreenOverlay"),
	gameOver = require("screens.overlays.GameOverOverlay")
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

local function onPlayerDeath()
	game:pause(true)
	overlay.overlay.isActive = false
	overlay.gameOver.isVisible = true
end

game.onPlayerDeath = onPlayerDeath

function screen:Load(ScreenManager)
	game:load(ScreenManager)
	overlay.pause:load(ScreenManager)
	overlay.gameOver:load(ScreenManager)
	overlay.overlay:load()
end

function screen:Update( dt )
	game:update(dt)
	overlay.pause:update()
	overlay.gameOver:update()
	overlay.overlay:update(dt)
end

function screen:Draw()
	game:draw()
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