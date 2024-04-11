local Suit = require('/lib/suit/')

local screen = {}

local labelFont = love.graphics.newFont(24)

local sound = {
  music = love.audio.newSource("/sound/music/intro_theme.mp3", "stream"),
	menu = {
		highlight = love.audio.newSource("/sound/menu/Rise01.mp3", "static"),
		select = love.audio.newSource("/sound/menu/Rise02.mp3", "static")
	}
}

local rWidth = 200
local rHeight = 30
local paddingX = 0
local paddingY = 10
local centerX = (love.graphics.getWidth() - rWidth - paddingX) / 2
local centerY = (love.graphics.getHeight() - rHeight - paddingY) / 2

function screen:Load(ScreenManager)
    self.ScreenManager = ScreenManager
    sound.music:stop()
    sound.music:play()
end

function screen:Draw() end

function screen:Update()
  Suit.layout:reset(centerX, centerY)
  Suit.layout:padding(paddingX, paddingY)

  Suit.Label("Infinite Runner", {font=labelFont}, Suit.layout:row(rWidth, rHeight))

  local state = Suit.Button("Play", Suit.layout:row())
  if state.entered then
    sound.menu.highlight:stop()
    sound.menu.highlight:play()
  elseif state.hit then
    sound.menu.select:stop()
    sound.menu.select:play()
    self.ScreenManager:SwitchStates("game")
    sound.music:stop()
  end

  state = Suit.Button("Quit", Suit.layout:row())
  if state.entered then
    sound.menu.highlight:stop()
    sound.menu.highlight:play()
  elseif state.hit then
    sound.menu.select:stop()
    sound.menu.select:play()
    love.event.quit()
    sound.music:stop()
  end
end

return screen
