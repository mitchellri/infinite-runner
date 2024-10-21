--[[	OBJECTS	]]
--[[
	Objects to be used in the game
	This is the exported table
]]

Objects = {
	Character = require("objects/objects/character"),
	Floor = require("objects/objects/floor"),
	Rock = require("objects/objects/rock"),
	Social = require("objects/objects/social"),
}

Objects.Speed = 0

return Objects