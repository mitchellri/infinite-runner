local overlay = {
    isVisible = true,
    isActive = true,
    time = 0,
    score = 0
}

function overlay:load()
  self.isVisible = true
  self.isActive = true
  self.time = 0
  self.score = 0
end

function overlay:draw()
    love.graphics.print("Time: " .. tostring(math.floor(self.time)) .. "s")
    love.graphics.print("Score: " .. tostring(math.floor(self.score)) .. " ", 0, 10)
end

function overlay:update(dt)
  if self.isActive then
    self.time = self.time + dt
  end

  if self.isActive then
    self.score = self.score + self.time/2*math.exp(0.005)
  end
end

function overlay:toggle(newVisible)
  if (newVisible == true) or (newVisible == false) then self.isVisible = newVisible
  else self.isVisible = not self.isVisible end
end

function overlay:quit()
  self:toggle(false)
end

return overlay
