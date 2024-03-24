background = {
    background_image = love.graphics.newImage("images/background/BG2.png"),  
    background_speed = -100,
    x = 0,
    a = -20
}

function background:update(dt)
    self.background_speed = self.background_speed + dt*self.a
    self.x = self.x + dt*(self.background_speed)
    if math.abs(self.x) > self.background_image:getWidth() then
        self.x = 0
    end
end

function background:draw()
    love.graphics.draw(self.background_image, self.x, 0)
	love.graphics.draw(self.background_image, self.x + self.background_image:getWidth(), 0)
end

return background