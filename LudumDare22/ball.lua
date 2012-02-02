require "boundingBox"
require "physics"

function newBall(filename)
	local l_ball = {}

	l_ball.bBox = nil
	l_ball.speed = 10
	l_ball.physics = nil
	l_ball.sprite = love.graphics.newImage(filename)
	l_ball.minX = 0
	l_ball.minY = 0
	l_ball.maxX = 0
	l_ball.maxY = 0
	l_ball.hitGoal = false

	function l_ball.init()
		l_ball.bBox = newBoundingBox()

		local startForce = newVec2(l_ball.speed, math.random() * l_ball.speed)
		local startPos = newVec2(l_ball.maxX / 2, l_ball.maxY / 2)

		l_ball.physics = newPhysics(startForce, startPos)
		l_ball.physics.setMaxForce(100)
		l_ball.setRadius(l_ball.sprite:getWidth() / 2)
	end

	function l_ball.setPosition(x, y)
		l_ball.bBox.setPosition(x, y)
	end

	function l_ball.getPosition()
		return l_ball.bBox.pos.x, l_ball.bBox.pos.y
	end

	function l_ball.setRadius(radius)
		l_ball.bBox.setWidth(radius * 2)
		l_ball.bBox.setHeight(radius * 2)
	end

	function l_ball.getRadius()
		return l_ball.bBox.getWidth() / 2
	end

	function l_ball.setSpeed(speed)
		l_ball.speed = speed
	end

	function l_ball.hasHitGoal()
		return l_ball.physics.getX() - l_ball.getRadius() <= l_ball.minX
	end

	function l_ball.update(dt)

		l_ball.physics.update(dt)

		--[[l_ball.physics.setPosition(clamp(l_ball.physics.getX(), l_ball.getWidth() / 2, love.graphics.getWidth() - l_ball.getWidth() / 2),
			clamp(l_ball.physics.getY(), l_ball.getHeight() / 2, love.graphics.getHeight() - l_ball.getHeight() / 2))]]

		if (l_ball.hasHitGoal()) then
			l_ball.hitGoal = true
		elseif (l_ball.physics.getX() + l_ball.getRadius() >= l_ball.maxX) then
			l_ball.bounceX()
		end

		if (l_ball.physics.getY() - l_ball.getRadius() <= l_ball.minY or
			l_ball.physics.getY() + l_ball.getRadius() >= l_ball.maxY) then
			l_ball.bounceY()
		end

		l_ball.bBox.setPosition(l_ball.physics.getX(), l_ball.physics.getY())
		--[[l_ball.bBox.pos.y = clamp(l_ball.bBox.pos.y, 0, love.graphics.getHeight() - l_ball.bBox.height)

		if l_ball.bBox.intersects(love.mouse.getPosition()) then
			l_ball.bBox.setDrawMode("fill")
		else
			l_ball.bBox.setDrawMode("line")
		end]]
	end

	function l_ball.bounceX()
		l_ball.physics.applyForce(-2 * l_ball.physics.netForce.x, 0)
	end

	function l_ball.bounceY()
		l_ball.physics.applyForce(0, -2 * l_ball.physics.netForce.y)
	end

	function l_ball.intersects(bBox)
		return l_ball.bBox.bIntersects(bBox)
	end

	function l_ball.draw()
		--love.graphics.circle("fill", l_ball.physics.getX(),
			--	l_ball.physics.getY(), l_ball.getRadius(), 30)
		love.graphics.draw(l_ball.sprite,
			l_ball.physics.getX() - l_ball.getRadius(),
			l_ball.physics.getY() - l_ball.getRadius())
	end

	function l_ball.setBounds(minX, maxX, minY, maxY)
		l_ball.minX = minX
		l_ball.minY = minY
		l_ball.maxX = maxX
		l_ball.maxY = maxY
	end

	return l_ball
end
