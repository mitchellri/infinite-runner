local screen = {}
local views = {
	game = require("screens.views.GameView"),
	settings = require("screens.views.SettingsView"),
	pause = require("screens.views.PauseView"),
	overlay = require("screens.views.GameOverlayView"),
	gameOver = require("screens.views.GameOverView")
}
local sound = {
	music = love.audio.newSource("/sound/music/happy.mp3", "stream")
}

local function onPauseOpen()
	views.game:pause(true)
	views.overlay.isActive = false
end

local function onPauseClose()
	views.game:pause(false)
	views.overlay.isActive = true
end

local function onQuit()
	sound.music:stop()
end

local function onSettings()
	views.settings.isVisible = true
	views.pause.isVisible = false
end

local function onExitSettings()
	views.settings.isVisible = false
	views.pause.isVisible = true
end

local function onPlayerDeath()
	views.game:pause(true)
	views.overlay.isActive = false
	views.gameOver.isVisible = true
end

function screen:Load(ScreenManager)
	self.ScreenManager = ScreenManager
	views.game:load(ScreenManager)
	views.game.onPlayerDeath = onPlayerDeath
	views.settings:load(ScreenManager)
	views.settings.onExitSettings = onExitSettings
	views.pause:load(ScreenManager)
	views.pause.onOpen = onPauseOpen
	views.pause.onClose = onPauseClose
	views.pause.onQuit = onQuit
	views.pause.onSettings = onSettings
	views.gameOver:load(ScreenManager)
	views.gameOver.onQuit = onQuit
	views.overlay:load()
	sound.music:play()
	sound.music:setLooping(true)
end

function screen:Update( dt )
	views.game:update(dt)
	views.settings:update(dt)
	views.pause:update()
	views.gameOver:update()
	views.overlay:update(dt)
end

function screen:Draw()
	views.game:draw()
	views.overlay:draw()
end

function screen:KeyPressed(key)
	if (not views.gameOver.isVisible) and (not views.settings.isVisible) then
		views.pause:keypressed(key)
	end
	if (not views.pause.isVisible) and (not views.gameOver.isVisible) and (not views.settings.isVisible) then
		views.game:keypressed(key)
	end
end

return screen