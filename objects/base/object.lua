-- All objects must contain these attributes
return {
	color = {1, 1, 1, 1},
	width = 0,
	height = 0,
	body = nil,
	fixture = nil,
	draw = function() end,
	beginContact = function(object, col) end,
	endContact = function(object, col) end,
	preSolve = function(object, col) end,
	postSolve = function(object, col, normalImpulse, tangentImpulse) end
}