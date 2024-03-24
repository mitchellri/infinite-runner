--Work in progress
-- background:setWrap("repeat", "repeat")  

-- background = {
--     background_image = love.graphics.newImage("BG1.png"),  
--     background_speed = 100,
--     x = 0
-- }

-- function background:update(dt)
--     self.x = self.x + dt*(self.background_speed)
--     if math.abs(self.x) > self.background_image:getWidth() then
--         self.x = 0
--     end
-- end

-- function background:draw()
--     love.graphics.draw(self.background_image, 0, self.x)
-- 	love.graphics.draw(self.background_image, 0, self.x - self.background_image:getWidth())
-- end

-- return background

-- background = {
--     background_image = love.graphics.newImage("BG1.png"),  
--     background_speed = -100,
--     y = 0
-- }

-- function background:update(dt)
--     self.y = self.y + dt*(self.background_speed)
--     if math.abs(self.y) > self.background_image:getHeight() then
--         self.y = 0
--     end
-- end

-- function background:draw()
--     love.graphics.draw(self.background_image, self.y, 0)
-- 	love.graphics.draw(self.background_image, self.y - self.background_image:getHeight(), 0)
-- end

-- return background


background = {
    background_image = love.graphics.newImage("images/background/BG1.png"),  
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