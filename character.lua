
	Character = {}

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

	function Character.new(world)
		newcharacter = {}
		newcharacter.width = 30
		newcharacter.height = 100

		newcharacter.body = love.physics.newBody( world, 0, 0, "dynamic")
		newcharacter.shape = love.physics.newRectangleShape( 0, 30, newcharacter.width, newcharacter.height, 0 )
		newcharacter.fixture = love.physics.newFixture( newcharacter.body, newcharacter.shape, 1 )
		function newcharacter:draw() --(pass in self- hidden newcharacter)
			--where I use the char to show on the screen
			love.graphics.rectangle("fill", 
			self.body:getX(),--because of : no longer need newcharacter.body:getY()
			self.body:getY(),
			self.width, 
			self.height)

		end 

		return newcharacter
	end

	return Character