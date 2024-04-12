local screen = {}
local subscreens = {
  menu = require("screens.subscreens.MainScreenMenu"),
  settings = require("screens.subscreens.SettingsMenu")
}

local sound = {
	music = love.audio.newSource("/sound/music/intro_theme.mp3", "stream")
}

local function onExitMainScreen()
  sound.music:stop()
end

local function onSettings()
  subscreens.settings.isVisible = true
  subscreens.menu.isVisible = false
end

local function onExitSettings()
  subscreens.settings.isVisible = false
  subscreens.menu.isVisible = true
end

function screen:Load(ScreenManager)
	subscreens.menu:load(ScreenManager)
  subscreens.menu.onExitMainScreen = onExitMainScreen
  subscreens.menu.onSettings = onSettings
  subscreens.settings:load(ScreenManager)
  subscreens.settings.onExitSettings = onExitSettings
  sound.music:setLooping(true)
	sound.music:play()
end

function screen:Update( dt )
	subscreens.menu:update(dt)
	subscreens.settings:update(dt)
end

function screen:Draw() end

return screen