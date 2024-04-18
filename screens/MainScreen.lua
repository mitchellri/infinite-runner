local screen = {}
local views = {
  menu = require("screens.views.MainMenuView"),
  settings = require("screens.views.SettingsView")
}

local sound = {
	music = love.audio.newSource("/sound/music/intro_theme.mp3", "stream")
}

local function onExitMainScreen()
  sound.music:stop()
end

local function onSettings()
  views.settings.isVisible = true
  views.menu.isVisible = false
end

local function onExitSettings()
  views.settings.isVisible = false
  views.menu.isVisible = true
end

function screen:Load(ScreenManager)
	views.menu:load(ScreenManager)
  views.menu.onExitMainScreen = onExitMainScreen
  views.menu.onSettings = onSettings
  views.settings:load(ScreenManager)
  views.settings.onExitSettings = onExitSettings
  sound.music:setLooping(true)
	sound.music:play()
end

function screen:Update( dt )
	views.menu:update(dt)
	views.settings:update(dt)
end

function screen:Draw() end

return screen