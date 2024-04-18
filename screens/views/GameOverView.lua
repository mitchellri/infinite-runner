local Suit = require('/lib/suit/')
local Yonder = require("lib.Yonder.exampleScreen")

local view = setmetatable({
  isVisible = false,
  onQuit = nil
}, {__index=Yonder})

local sound = {
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
local labelFont = love.graphics.newFont(24)

--[[	MAIN FUNCTIONS	]]

function view:Load(ScreenManager)
  self.ScreenManager = ScreenManager
  self.isVisible = false
  self.onQuit = nil
end

function view:Update()
  if self.isVisible then
    Suit.layout:reset(centerX, centerY)
    Suit.layout:padding(paddingX, paddingY)

    Suit.Label("Game Over", {font=labelFont}, Suit.layout:row(rWidth, rHeight))

    local state = Suit.Button("Retry", Suit.layout:row())
    if state.entered then
      sound.menu.highlight:stop()
      sound.menu.highlight:play()
    elseif state.hit then
      sound.menu.select:stop()
      sound.menu.select:play()
      self.ScreenManager:SwitchStates("game")
      self:quit()
    end

    state = Suit.Button("Quit", Suit.layout:row())
    if state.entered then
      sound.menu.highlight:stop()
      sound.menu.highlight:play()
    elseif state.hit then
      sound.menu.select:stop()
      sound.menu.select:play()
      if self.onQuit ~= nil then self.onQuit() end
      self.ScreenManager:SwitchStates("main")
      self:quit()
    end
  end
end

function view:KeyPressed(key) end

function view:quit()
  self.isVisible = false
end

return view
