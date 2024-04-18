local Yonder = require("lib.Yonder.exampleScreen")

local view = setmetatable({
    isPaused = false,
	onPlayerDeath = nil
}, {__index=Yonder})

local background = require("backGround")
local objects = require("objects")
local world = nil
local character = nil
local floor = nil
local rock = nil
local reward = nil

--[[ Collision ]]
local function beginContact(a, b, col)
	a = a:getUserData()
	b = b:getUserData()
	a:beginContact(b, col)
	b:beginContact(a, col)
end
local function endContact(a, b, col)
	a = a:getUserData()
	b = b:getUserData()
	a:endContact(b, col)
	b:endContact(a, col)
end
local function preSolve(a, b, col)
	a = a:getUserData()
	b = b:getUserData()
	a:preSolve(b, col)
	b:preSolve(a, col)
end
local function postSolve(a, b, col, normalImpulse, tangentImpulse)
	a = a:getUserData()
	b = b:getUserData()
	a:postSolve(b, col, normalImpulse, tangentImpulse)
	b:postSolve(a, col, normalImpulse, tangentImpulse)
end
--[[ /Collision ]]

--[[	LOCAL FUNCTIONS	]]

local function onPlayerDeath()
	if view.onPlayerDeath ~= nil then
		view:onPlayerDeath()
	end
end

--[[	MAIN FUNCTIONS	]]

function view:Load(ScreenManager)
	love.graphics.setBackgroundColor(0,0,0,0)
	love.keyboard.setKeyRepeat(true)

	self.isPaused = false
	self.onPlayerDeath = nil

	world = love.physics.newWorld( 0, 9.8*4 * love.physics.getMeter(), false )
	world:setCallbacks(beginContact, endContact, preSolve, postSolve)
	character = objects.Character.new(world, love.graphics.getWidth()/2, love.graphics.getHeight()/2)
	character.onDeath = onPlayerDeath
	floor = objects.Floor.new(world, 0, love.graphics.getHeight()-50/2, love.graphics.getWidth(), 50)
	rock = objects.Rock.new(world, love.graphics.getWidth() - 75, floor.body:getY() - 61)
	background:load()
	reward = Objects.Social.new(world, love.graphics.getWidth()-30, floor.body:getY() - 90)
end

function view:Update( dt )
	if not self.isPaused then
		world:update(dt)
		character:update(dt)
		background:update(dt)
		objects.Speed = background.background_speed
		rock:update(dt)
		reward:update(dt)
	end
end

function view:Draw()
	background:draw()
	floor:draw()
	rock:draw()
	character:draw()
	reward:draw()
end

function view:KeyPressed( key )
	character:keypressed( key )
end

--[[	OBJECT FUNCTIONS	]]

function view:pause(newPaused)
	self.isPaused = newPaused
end


return view