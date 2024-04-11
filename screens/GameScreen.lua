local screen = {}
local game = require("screens.subscreens.GameScreenGame")
local overlay = { -- Overlays only using Suit do not need to have draw() called
	pause = require("screens.overlays.PauseOverlay"),
	overlay = require("screens.overlays.GameScreenOverlay"),
	gameOver = require("screens.overlays.GameOverOverlay")
}
local sound = {
	music = love.audio.newSource("/sound/music/happy.mp3", "stream")
}
sound.music:setLooping(true)

local function onPauseOpen()
	game:pause(true)
	overlay.overlay.isActive = false
end

local function onPauseClose()
	game:pause(false)
	overlay.overlay.isActive = true
end

local function onQuit()
	sound.music:stop()
end

overlay.pause.onOpen = onPauseOpen
overlay.pause.onClose = onPauseClose
overlay.pause.onQuit = onQuit
overlay.gameOver.onQuit = onQuit

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
	sound.music:play()
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
	if not overlay.gameOver.isVisible then
		overlay.pause:keypressed(key)
	end
	if (not overlay.pause.isVisible) and (not overlay.gameOver.isVisible) then
		game:keypressed(key)
	end
end

return screen