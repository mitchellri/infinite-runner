local screen = {}
local subscreens = {
  menu = require("screens.subscreens.MainScreenMenu"),
  settings = require("screens.subscreens.SettingsMenu")
}

local sound = {
	music = love.audio.newSource("/sound/music/intro_theme.mp3", "stream")
}
sound.music:setLooping(true)

local function onExitMainScreen()
  sound.music:stop()
end

local function onSettings()
  subscreens.settings:load(screenManager)
  subscreens.settings.isVisible = true
  subscreens.menu.isVisible = false
end

local function onExitSettings()
  subscreens.settings.isVisible = false
  subscreens.menu.isVisible = true
end

subscreens.menu.onExitMainScreen = onExitMainScreen
subscreens.menu.onSettings = onSettings
subscreens.settings.onExitSettings = onExitSettings

function screen:Load(ScreenManager)
	subscreens.menu:load(ScreenManager)
  subscreens.settings:load(ScreenManager)
	sound.music:play()
end

function screen:Update( dt )
	subscreens.menu:update(dt)
	subscreens.settings:update(dt)
end

function screen:Draw() end

return screen