
	Character = {}
	Character.Character = {}
	Character.Floor = {}

	--set initial env
	-- Character.timer = 0
	-- Character.speed = 1

	-- function love.update( dt )
	-- 	-- STATE.update(dt)
	-- end
	
	function Character:draw() --pass in self
		--where I use the char to show on the screen
		love.graphics.rectangle("fill", 0,50, 40,120)
	end 

	-- function Character:
	-- function Character.move(timer)
	-- 	Character.move += timer*speed
	-- end

	function Character.Character.new(world)
		newcharacter = {}
		newcharacter.width = 30
		newcharacter.height = 100
		newcharacter.color = {1, 1, 1}

		local lx = love.graphics.getWidth() / 2
		local ly = love.graphics.getHeight() / 2
		newcharacter.body = love.physics.newBody( world, lx, ly, "dynamic")
		--[[
			The origin of rectangle is the center of the rectangle in this case
			Move the rectangle so the top left of the rectangle is at the origin of the body
		]]
		local shape = love.physics.newRectangleShape( newcharacter.width/2, newcharacter.height/2, newcharacter.width, newcharacter.height, 0 )
		newcharacter.fixture = love.physics.newFixture( newcharacter.body, shape, 1 ) -- Shape is copied not referenced
		function newcharacter:draw() --(pass in self- hidden newcharacter)
			love.graphics.setColor(self.color)

			-- Move the coordinate system origin (0, 0) to the location of the physical body
			love.graphics.translate(self.body:getX(), self.body:getY())
			-- Rotate the coordinate system (0, 0) by the rotation of the physical body
			love.graphics.rotate(self.body:getAngle()) -- body:getAngle returns the angle relative to the origin of the body

			-- Draw a regular rectangle at the now, translated and rotated coordinate system
			love.graphics.rectangle("fill",
			0,0,
			self.width,
			self.height)
			
			-- Return the coordinate system back to its default settings
			love.graphics.origin()
			love.graphics.setColor(1, 1, 1)
		end 

		return newcharacter
	end


	function Character.Floor.new(world)
		newcharacter = {}
		newcharacter.width = 1000
		newcharacter.height = 30
		newcharacter.color = {1, 0, 0}

		local lx = 0 --screen
		local ly = love.graphics.getHeight()-newcharacter.height/2
		newcharacter.body = love.physics.newBody( world, lx, ly, "static")
		--[[
			The origin of rectangle is the center of the rectangle in this case
			Move the rectangle so the top left of the rectangle is at the origin of the body
		]]
		local shape = love.physics.newRectangleShape( newcharacter.width/2, newcharacter.height/2, newcharacter.width, newcharacter.height, 0 )
		newcharacter.fixture = love.physics.newFixture( newcharacter.body, shape, 1 ) -- Shape is copied not referenced
		function newcharacter:draw() --(pass in self- hidden newcharacter)
			love.graphics.setColor(self.color)

			-- Move the coordinate system origin (0, 0) to the location of the physical body
			love.graphics.translate(self.body:getX(), self.body:getY())
			-- Rotate the coordinate system (0, 0) by the rotation of the physical body
			love.graphics.rotate(self.body:getAngle()) -- body:getAngle returns the angle relative to the origin of the body

			-- Draw a regular rectangle at the now, translated and rotated coordinate system
			love.graphics.rectangle("fill",
			0,0,
			self.width,
			self.height)
			
			-- Return the coordinate system back to its default settings
			love.graphics.origin()
			love.graphics.setColor(1, 1, 1)
		end 

		return newcharacter
	end

	return Character