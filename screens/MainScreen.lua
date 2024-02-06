local Suit = require('/lib/suit/')

local screen = {}

local labelFont = love.graphics.newFont(24)

local rWidth = 200
local rHeight = 30
local paddingX = 0
local paddingY = 10
local centerX = (love.graphics.getWidth() - rWidth - paddingX) / 2
local centerY = (love.graphics.getHeight() - rHeight - paddingY) / 2

function screen:Load(ScreenManager)
    self.ScreenManager = ScreenManager
end

function screen:Draw()
  Suit.draw()
end

function screen:Update()
  Suit.layout:reset(centerX, centerY)
  Suit.layout:padding(paddingX, paddingY)

  Suit.Label("Infinite Runner", {font=labelFont}, Suit.layout:row(rWidth, rHeight))

  if Suit.Button("Play", Suit.layout:row()).hit then
    self.ScreenManager:SwitchStates("game")
  end

  if Suit.Button("Quit", Suit.layout:row()).hit then
    love.event.quit()
  end
end

return screen
