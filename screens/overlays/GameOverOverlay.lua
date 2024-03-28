local Suit = require('/lib/suit/')

local overlay = {
  isVisible = false
}

local labelFont = love.graphics.newFont(24)

local rWidth = 200
local rHeight = 30
local paddingX = 0
local paddingY = 10
local centerX = (love.graphics.getWidth() - rWidth - paddingX) / 2
local centerY = (love.graphics.getHeight() - rHeight - paddingY) / 2

function overlay:load(ScreenManager)
  self.ScreenManager = ScreenManager
end

function overlay:draw() end

function overlay:update()
  if self.isVisible then
    Suit.layout:reset(centerX, centerY)
    Suit.layout:padding(paddingX, paddingY)

    Suit.Label("Game Over", {font=labelFont}, Suit.layout:row(rWidth, rHeight))

    if Suit.Button("Retry", Suit.layout:row()).hit then
      self.ScreenManager:SwitchStates("game")
      self:quit()
    end

    if Suit.Button("Quit", Suit.layout:row()).hit then
      self.ScreenManager:SwitchStates("main")
      self:quit()
    end
  end
end

function overlay:keypressed(key) end

function overlay:quit()
  self.isVisible = false
end

return overlay
