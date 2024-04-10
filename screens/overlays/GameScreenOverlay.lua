local overlay = {
    isVisible = true,
    isActive = true,
    time = 0
}

function overlay:load()
  self.isVisible = true
  self.isActive = true
  self.time = 0
end

function overlay:draw()
    love.graphics.print("Time: " .. tostring(math.floor(self.time)) .. "s")
end

function overlay:update(dt)
  if self.isActive then
    self.time = self.time + dt
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
