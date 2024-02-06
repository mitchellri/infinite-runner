local Suit = require('/lib/suit/')

local overlay = {
  isActive = false
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

function overlay:draw()
    Suit.draw() -- for some reason this needs to be called consistently or else it breaks
end

function overlay:update()
  if self.isActive then
    Suit.layout:reset(centerX, centerY)
    Suit.layout:padding(paddingX, paddingY)

    Suit.Label("Pause", {font=labelFont}, Suit.layout:row(rWidth, rHeight))

    if Suit.Button("Resume", Suit.layout:row()).hit then
      self:quit()
    end
    
    if Suit.Button("Reset", Suit.layout:row()).hit then
      self.ScreenManager:SwitchStates("game")
      self:quit()
    end

    if Suit.Button("Quit", Suit.layout:row()).hit then
      self.ScreenManager:SwitchStates("main")
      self:quit()
    end
  end
end

function overlay:toggle()
  self.isActive = not self.isActive
end

function overlay:quit()
  self.isActive = false
end

return overlay
