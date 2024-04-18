local Yonder = require("lib.Yonder.exampleScreen")

local view = setmetatable({
  isVisible = true,
  isActive = true,
  time = 0,
  score = 0
}, {__index=Yonder})

--[[	MAIN FUNCTIONS	]]

function view:Load()
  self.isVisible = true
  self.isActive = true
  self.time = 0
  self.score = 0
end

function view:Draw()
    love.graphics.print("Time: " .. tostring(math.floor(self.time)) .. "s")
    love.graphics.print("Score: " .. tostring(math.floor(self.score)) .. " ", 0, 10)
end

function view:Update(dt)
  if self.isActive then
    self.time = self.time + dt
  end

  if self.isActive then
    self.score = self.score + self.time/2*math.exp(0.005)
  end
end

--[[	OBJECT FUNCTIONS	]]

function view:toggle(newVisible)
  if (newVisible == true) or (newVisible == false) then self.isVisible = newVisible
  else self.isVisible = not self.isVisible end
end

function view:quit()
  self:toggle(false)
end

return view
