local Suit = require('/lib/suit/')

local view = {
    isVisible = true,
    onExitMainScreen = nil,
    onSettings = nil
}

local labelFont = love.graphics.newFont(24)

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

function view:load(ScreenManager)
    self.ScreenManager = ScreenManager
    self.isVisible = true
    self.onExitMainScreen = nil
    self.onSettings = nil
end

function view:update()
    if self.isVisible then
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
            if self.onExitMainScreen ~= nil then self.onExitMainScreen() end
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

        state = Suit.Button("Quit", Suit.layout:row())
        if state.entered then
            sound.menu.highlight:stop()
            sound.menu.highlight:play()
        elseif state.hit then
            sound.menu.select:stop()
            sound.menu.select:play()
            love.event.quit()
            if self.onExitMainScreen ~= nil then self.onExitMainScreen() end
        end
    end
end

return view
