local constants = require("constants")
local object = require("objects/base/object")

local character = setmetatable({}, {__index = object})

character.animation = {
    walk = newAnimation(love.graphics.newImage("images/Player/walk.png"), 21, 16, 0.1, 8),
    jump = newAnimation(love.graphics.newImage("images/Player/jump.png"), 22, 18, 0.05, 4),
    land = newAnimation(love.graphics.newImage("images/Player/land.png"), 22, 18, 0.04, 6)
}
character.animation.jump:setMode("once")
character.animation.land:setMode("once")
character.animation.current = character.animation.walk

character.sound = {
    jump = love.audio.newSource("/sound/game/sfx_movement_jump14.wav", "static"),
}

character.scale = 5
character.radius = math.min(character.animation.current:getWidth() * character.scale, character.animation.current:getHeight() * character.scale) / 2 * constants.objects.bodyScale
character.jumpVelocity = 1200/2

character.onDeath = nil

function character:preSolve(object, col)
    if object.fixture:getBody():getType() == "dynamic" then
        if object.type == constants.objects.type.obstacle then
            self:die()
        end
    else
        vx, vy = self.body:getLinearVelocity()
        if (self.animation.current == self.animation.jump) and vy > 0 then
            self.animation.jump:stop()
            self.animation.current = self.animation.land
            self.animation.land:reset()
            self.animation.land:play()
        elseif (self.animation.current == self.animation.land) and not self.animation.current.playing then
            self.animation.land:stop()
            self.animation.current = self.animation.walk
            self.animation.walk:play()
        end
    end
end

function character:die()
    if self.onDeath ~= nil then
        self:onDeath()
    end
end

function character:jump( )
    self.body:setLinearVelocity( 0, -character.jumpVelocity )
    self.animation.current:stop()
    self.animation.current = self.animation.jump
    self.animation.jump:reset()
    self.animation.jump:play()
    self.sound.jump:stop()
    self.sound.jump:play()
end

function character:keypressed( key )
    if(key == "j") then
        self:jump()
    end
end

function character:update(dt)
    self.animation.current:update(dt)
end

function character:draw()
    -- Body origin is the center of the circle, animation origin is the top left of the animation
    -- Subtract radius to align with top left of the body as if it were a rectangle
    -- Add the diference between the body width and the animation
    -- This draws the center of the image at the center of the body
    -- WARNING: Rotation is not correctly accounted for in this draw
    self.animation.current:draw(self.body:getX() - self.radius + (self.radius*2 - self.animation.current:getWidth() * self.scale) / 2, self.body:getY() - self.radius + (self.radius*2 - self.animation.current:getHeight() * self.scale) / 2, self.body:getAngle(), self.scale)
end

return character