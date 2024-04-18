local Yonder = require("lib.Yonder.exampleScreen")

local screen = setmetatable({}, {__index=Yonder})
local views = {
	game = require("screens.views.GameView"),
	pause = require("screens.views.PauseView"),
	overlay = require("screens.views.GameOverlayView"),
	gameOver = require("screens.views.GameOverView")
}
local sound = {
	music = love.audio.newSource("/sound/music/happy.mp3", "stream")
}

--[[	LOCAL FUNCTIONS	]]

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

local function onPlayerDeath()
	views.game:pause(true)
	views.overlay.isActive = false
	views.gameOver.isVisible = true
end

--[[	MAIN FUNCTIONS	]]

function screen:Load(ScreenManager)
	self.ScreenManager = ScreenManager
	views.game:Load(ScreenManager)
	views.game.onPlayerDeath = onPlayerDeath
	views.pause:Load(ScreenManager)
	views.pause.onOpen = onPauseOpen
	views.pause.onClose = onPauseClose
	views.pause.onQuit = onQuit
	views.pause.onSettings = onSettings
	views.gameOver:Load(ScreenManager)
	views.gameOver.onQuit = onQuit
	views.overlay:Load()
	sound.music:play()
	sound.music:setLooping(true)
end

function screen:Update( dt )
	views.game:Update(dt)
	views.pause:Update()
	views.gameOver:Update()
	views.overlay:Update(dt)
end

function screen:Draw()
	views.game:Draw()
	views.overlay:Draw()
end

function screen:KeyPressed(key)
	if not views.gameOver.isVisible then
		views.pause:KeyPressed(key)
	end
	if (not views.pause.isVisible) and (not views.gameOver.isVisible) then
		views.game:KeyPressed(key)
	end
end

return screen