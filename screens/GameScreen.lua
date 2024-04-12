local screen = {}
local subscreens = {
	game = require("screens.subscreens.GameScreenGame"),
	settings = require("screens.subscreens.SettingsMenu")
}
local overlay = { -- Overlays only using Suit do not need to have draw() called
	pause = require("screens.overlays.PauseOverlay"),
	overlay = require("screens.overlays.GameScreenOverlay"),
	gameOver = require("screens.overlays.GameOverOverlay")
}
local sound = {
	music = love.audio.newSource("/sound/music/happy.mp3", "stream")
}

local function onPauseOpen()
	subscreens.game:pause(true)
	overlay.overlay.isActive = false
end

local function onPauseClose()
	subscreens.game:pause(false)
	overlay.overlay.isActive = true
end

local function onQuit()
	sound.music:stop()
end

local function onSettings()
	subscreens.settings.isVisible = true
	overlay.pause.isVisible = false
end

local function onExitSettings()
	subscreens.settings.isVisible = false
	overlay.pause.isVisible = true
end

local function onPlayerDeath()
	subscreens.game:pause(true)
	overlay.overlay.isActive = false
	overlay.gameOver.isVisible = true
end

function screen:Load(ScreenManager)
	self.ScreenManager = ScreenManager
	subscreens.game:load(ScreenManager)
	subscreens.game.onPlayerDeath = onPlayerDeath
	subscreens.settings:load(ScreenManager)
	subscreens.settings.onExitSettings = onExitSettings
	overlay.pause:load(ScreenManager)
	overlay.pause.onOpen = onPauseOpen
	overlay.pause.onClose = onPauseClose
	overlay.pause.onQuit = onQuit
	overlay.pause.onSettings = onSettings
	overlay.gameOver:load(ScreenManager)
	overlay.gameOver.onQuit = onQuit
	overlay.overlay:load()
	sound.music:play()
	sound.music:setLooping(true)
end

function screen:Update( dt )
	subscreens.game:update(dt)
	subscreens.settings:update(dt)
	overlay.pause:update()
	overlay.gameOver:update()
	overlay.overlay:update(dt)
end

function screen:Draw()
	subscreens.game:draw()
	overlay.overlay:draw()
end

function screen:KeyPressed(key)
	if (not overlay.gameOver.isVisible) and (not subscreens.settings.isVisible) then
		overlay.pause:keypressed(key)
	end
	if (not overlay.pause.isVisible) and (not overlay.gameOver.isVisible) and (not subscreens.settings.isVisible) then
		subscreens.game:keypressed(key)
	end
end

return screen