require "physics"
--require "weapon"

--gameObj =
--{
	--pos = nil
	--image = nil
	--physics = nil
	--moveLeft = nil
	--moveRight = nil
	--moveUp = nil
	--moveDown = nil
	--update = nil
	--draw = nil


--}

--gameObj.weapon = nil


	--	gameObj.shoot = function()
	--		gameObj.weapon.shoot(gameObj.physics.netForce)
	--	end


newGameObj = function(imageName)
		local gameObj = {}
		gameObj.image = love.graphics.newImage(imageName)
		gameObj.pos = newVec2(0, 0)
		gameObj.physics = newPhysics(newVec2(0, 0), newVec2(0, 0))

		gameObj.init = function()
			gameObj.physics.position = gameObj.center()
		end

		function gameObj.moveLeft(dt)
			gameObj.physics.applyForce(-1, 0)
		end

		function gameObj.moveRight(dt)
			gameObj.physics.applyForce(1, 0)
		end

		gameObj.moveUp = function(dt)
			gameObj.physics.applyForce(0, -1)
		end

		gameObj.moveDown = function(dt)
			gameObj.physics.applyForce(0, 1)
		end


		gameObj.update = function(dt)
			gameObj.physics.update(dt)
		end

		gameObj.draw = function()
			love.graphics.draw(gameObj.image, gameObj.physics.getX(), gameObj.physics.getY())
		end

		gameObj.center = function()
			return newVec2(gameObj.image:getWidth() / 2, gameObj.image:getHeight() / 2)
		end

		return gameObj
end



