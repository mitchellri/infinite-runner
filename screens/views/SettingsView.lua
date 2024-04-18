local Suit = require('/lib/suit/')

local view = {
    isVisible = false,
    onExitSettings = nil
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
local paddingX = 5
local paddingY = 10
local centerX = (love.graphics.getWidth() - rWidth - paddingX) / 2
local centerY = (love.graphics.getHeight() - rHeight - paddingY) / 2

local slider = {value = 0, min = 0, max = 100}

local previousSettings = {
    volume = 0
}

local function saveNewSettings()
    previousSettings.volume = love.audio.getVolume()
end

local function restorePreviousSettings()
    slider.value = previousSettings.volume * 100
    love.audio.setVolume(previousSettings.volume)
end

function view:load(ScreenManager)
    self.ScreenManager = ScreenManager
    self.isVisible = false
    self.onExitSettings = nil

    previousSettings.volume = love.audio.getVolume()

    slider.value = love.audio.getVolume() * 100
end

function view:update()
    if self.isVisible then
        Suit.layout:reset(centerX, centerY, paddingX, paddingY)

        Suit.Label("Settings", {font=labelFont}, Suit.layout:row(rWidth, rHeight))

        Suit.layout:push(Suit.layout:row())

        local state = Suit.Slider(slider, Suit.layout:col(rWidth*3/4, rHeight))
        Suit.Label(("%.0f"):format(slider.value), Suit.layout:col(rWidth/4))
        Suit.layout:pop()

        if state then
            love.audio.setVolume(slider.value/100)
        end

        Suit.layout:push(Suit.layout:row())

        state = Suit.Button("Confirm", Suit.layout:col(rWidth/2, rHeight))
        if state.entered then
            sound.menu.highlight:stop()
            sound.menu.highlight:play()
        elseif state.hit then
            sound.menu.select:stop()
            sound.menu.select:play()
            saveNewSettings()
            if self.onExitSettings ~= nil then self.onExitSettings() end
        end

        state = Suit.Button("Cancel", Suit.layout:col())
        if state.entered then
            sound.menu.highlight:stop()
            sound.menu.highlight:play()
        elseif state.hit then
            sound.menu.select:stop()
            sound.menu.select:play()
            restorePreviousSettings()
            if self.onExitSettings ~= nil then self.onExitSettings() end
        end

        Suit.layout:pop()
    end
end

return view
