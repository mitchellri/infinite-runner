
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

		local lx = love.graphics.getWidth() / 2
		local ly = love.graphics.getHeight() / 2
		newcharacter.body = love.physics.newBody( world, lx, ly, "dynamic")
		newcharacter.shape = love.physics.newRectangleShape( lx, ly, newcharacter.width, newcharacter.height, 0 )
		newcharacter.fixture = love.physics.newFixture( newcharacter.body, newcharacter.shape, 1 )
		function newcharacter:draw() --(pass in self- hidden newcharacter)
			-- love.graphics.push()
			local dx, dy = self.body:getX() + self.width / 2, self.body:getY() + self.height / 2
			-- love.graphics.translate(dx, dy)
			-- love.graphics.rotate(1)
			
			love.graphics.push()
			love.graphics.translate(dx, dy)
			love.graphics.rotate(self.body:getAngle())
			

			--where I use the char to show on the screen
			love.graphics.rectangle("fill", 
			0,--because of : no longer need newcharacter.body:getY()
			0,
			self.width, 
			self.height)
			-- love.graphics.translate(-dx, -dy)
			love.graphics.pop()
		end 

		return newcharacter
	end


	function Character.Floor.new(world)
		newcharacter = {}
		newcharacter.width = 1000
		newcharacter.height = 30

		local lx = 0 --screen
		local ly = love.graphics.getHeight()-newcharacter.height/2
		newcharacter.body = love.physics.newBody( world, lx, ly, "static")
		newcharacter.shape = love.physics.newRectangleShape( lx, ly, newcharacter.width, newcharacter.height, 0 )
		newcharacter.fixture = love.physics.newFixture( newcharacter.body, newcharacter.shape, 1 )
		function newcharacter:draw() --(pass in self- hidden newcharacter)
			-- love.graphics.push()
			--where I use the char to show on the screen
			love.graphics.setColor(1, 0, 0)
			love.graphics.rectangle("fill", 
			self.body:getX(),--because of : no longer need newcharacter.body:getY()
			self.body:getY(),
			self.width, 
			self.height)
			love.graphics.setColor(1, 1, 1)
			-- love.graphics.pop()

		end 

		return newcharacter
	end

	return Character