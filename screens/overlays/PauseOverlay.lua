local Suit = require('/lib/suit/')

local overlay = {
  isVisible = false,
  onClose = nil,
  onQuit = nil,
  onSettings = nil
}

local sound = {
  menu = {
		highlight = love.audio.newSource("/sound/menu/Rise01.mp3", "static"),
		toggle = love.audio.newSource("/sound/menu/Rise03.mp3", "static"),
		select = love.audio.newSource("/sound/menu/Rise02.mp3", "static")
	}
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
  self.isVisible = false
  self.onClose = nil
  self.onQuit = nil
  self.onSettings = nil
end

function overlay:draw() end

function overlay:update()
  if self.isVisible then
    Suit.layout:reset(centerX, centerY)
    Suit.layout:padding(paddingX, paddingY)

    Suit.Label("Pause", {font=labelFont}, Suit.layout:row(rWidth, rHeight))

    local state = Suit.Button("Resume", Suit.layout:row())
    if state.entered then
      sound.menu.highlight:stop()
      sound.menu.highlight:play()
    elseif state.hit then
      sound.menu.select:stop()
      sound.menu.select:play()
      self:quit()
    end
    
    state = Suit.Button("Settings", Suit.layout:row())
    if state.entered then
      sound.menu.highlight:stop()
      sound.menu.highlight:play()
    elseif state.hit then
      sound.menu.select:stop()
      sound.menu.select:play()
      if self.onSettings ~= nil then self.onSettings() end
    end
    
    state = Suit.Button("Reset", Suit.layout:row())
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

function overlay:keypressed(key)
  if key == "escape" then
    sound.menu.toggle:stop()
    sound.menu.toggle:play()
    self:toggle()
  end
end

function overlay:toggle(newVisible)
  if (newVisible == true) or (newVisible == false) then self.isVisible = newVisible
  else self.isVisible = not self.isVisible end

  if not self.isVisible and (self.onClose ~= nil) then self.onClose()
  elseif self.isVisible and (self.onOpen ~= nil) then self.onOpen() end
end

function overlay:quit()
  self:toggle(false)
end

return overlay
