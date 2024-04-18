local Yonder = require("lib.Yonder.exampleScreen")

local screen = setmetatable({}, {__index=Yonder})
local views = {
  menu = require("screens.views.MainMenuView"),
  settings = require("screens.views.SettingsView")
}

local sound = {
	music = love.audio.newSource("/sound/music/intro_theme.mp3", "stream")
}

--[[	LOCAL FUNCTIONS	]]

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

--[[	MAIN FUNCTIONS	]]

function screen:Load(ScreenManager)
	views.menu:Load(ScreenManager)
  views.menu.onExitMainScreen = onExitMainScreen
  views.menu.onSettings = onSettings
  views.settings:Load(ScreenManager)
  views.settings.onExitSettings = onExitSettings
  sound.music:setLooping(true)
	sound.music:play()
end

function screen:Update(dt)
	views.menu:Update(dt)
	views.settings:Update(dt)
end

return screen