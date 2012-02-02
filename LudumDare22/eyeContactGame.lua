require "pedestrian"

function newEyeContactGame()
	local eye = {}

	eye.pedestrian = nil
	eye.sideWalk = nil

	function eye.init()
		eye.pedestrian = newPedestrian("assets/walk_spritesheet.png", 2, 4)
		eye.pedestrian.setStartPos(350, 0)
		eye.pedestrian.setEndPos(-700, 100)
		eye.pedestrian.setTransPos(0, 100)
		eye.pedestrian.init()

		local horizMargin = 0.15

		eye.sideWalk = {}
		eye.sideWalk.left = {}
		eye.sideWalk.left.top = {x = love.graphics.getWidth() * 0.35, y = love.graphics.getHeight() * horizMargin}
		eye.sideWalk.left.bottom = {x = 0, y = love.graphics.getHeight()}

		eye.sideWalk.right = {}
		eye.sideWalk.right.top = {x = love.graphics.getWidth() * 0.65, y = love.graphics.getHeight() * horizMargin}
		eye.sideWalk.right.bottom = {x = love.graphics.getWidth(), y = love.graphics.getHeight()}
	end

	function eye.update(dt)
		eye.pedestrian.update(dt)
	end

	function eye.draw()
		love.graphics.setBackgroundColor(255, 255, 255)
		eye.pedestrian.draw()
		love.graphics.setColor(255, 0, 0, 255)
		love.graphics.line(eye.sideWalk.left.top.x, eye.sideWalk.left.top.y,
			eye.sideWalk.left.bottom.x, eye.sideWalk.left.bottom.y)
		love.graphics.line(eye.sideWalk.right.top.x, eye.sideWalk.right.top.y,
			eye.sideWalk.right.bottom.x, eye.sideWalk.right.bottom.y)

		love.graphics.print("Mouse pos = " .. love.mouse.getX() .. love.mouse.getY(), 50, 50)
	end

	function eye.isGameOver()
		return false
	end

	function eye.hasWon()
		return false
	end

	return eye
end
