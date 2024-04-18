local Suit = require('/lib/suit/')
local Yonder = require("lib.Yonder.exampleScreen")

local view = setmetatable({
  isVisible = false,
  currentView = nil,
  onClose = nil,
  onQuit = nil
}, {__index=Yonder})

local views = {
  settings = require("screens.views.SettingsView")
}

local sound = {
  menu = {
		highlight = love.audio.newSource("/sound/menu/Rise01.mp3", "static"),
		toggle = love.audio.newSource("/sound/menu/Rise03.mp3", "static"),
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

--[[	LOCAL FUNCTIONS	]]

local function onSettings()
	view.currentView = "settings"
  views.settings.isVisible = true
end

local function onExitSettings()
	view.currentView = nil
  views.settings.isVisible = true
end

--[[	MAIN FUNCTIONS	]]

function view:Load(ScreenManager)
  self.ScreenManager = ScreenManager
  views.settings:Load(ScreenManager)
  views.settings.onExitSettings = onExitSettings
  self.isVisible = false
  self.currentView = nil
  self.onClose = nil
  self.onQuit = nil
end

function view:Update()
  if self.isVisible then
    if self.currentView == nil then
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
        onSettings()
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
    else
      views[self.currentView]:Update()
    end
  end
end

function view:KeyPressed(key)
  if key == "escape" then
    sound.menu.toggle:stop()
    sound.menu.toggle:play()
    self:toggle()
  end
end

--[[	OBJECT FUNCTIONS	]]

function view:toggle(newVisible)
  if (newVisible == true) or (newVisible == false) then self.isVisible = newVisible
  else self.isVisible = not self.isVisible end

  if not self.isVisible and (self.onClose ~= nil) then self.onClose()
  elseif self.isVisible and (self.onOpen ~= nil) then self.onOpen() end
end

function view:quit()
  self:toggle(false)
end

return view
