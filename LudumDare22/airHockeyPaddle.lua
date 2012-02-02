require "paddle"
require "BoundingCircle"


function newAirHockeyPaddle(filename)
	local l_paddle = newPaddle(filename)

	l_paddle.maxX = 0
	l_paddle.maxY = 0

	function l_paddle.setBounds(minY, maxY, minX, maxX)
		l_paddle.minY, l_paddle.maxY = minY, maxY
		l_paddle.minX, l_paddle.maxX = minX, maxX
	end

	function l_paddle.init()
		l_paddle.sprite = love.graphics.newImage(filename)

		l_paddle.bBox = newBoundingCircle()
		l_paddle.setRadius(l_paddle.sprite:getWidth() / 2)
	end

	function l_paddle.setRadius(radius)
		l_paddle.bBox.radius = radius
	end

	function l_paddle.setPosition(x, y)
		l_paddle.bBox.center.x = x
		l_paddle.bBox.center.y = y
	end

	function l_paddle.getPosition()
		return l_paddle.bBox.center.x, l_paddle.bBox.center.y
	end

	function l_paddle.update(dt)
		l_paddle.setPosition(love.mouse.getX(), love.mouse.getY())

		l_paddle.bBox.center.x = clamp(l_paddle.bBox.center.x,
			l_paddle.minX + l_paddle.bBox.radius, l_paddle.maxX - l_paddle.bBox.radius)
		l_paddle.bBox.center.y = clamp(l_paddle.bBox.center.y,
			l_paddle.minY + l_paddle.bBox.radius, l_paddle.maxY - l_paddle.bBox.radius)
	end

	function l_paddle.draw()
		local x, y = l_paddle.getPosition()

		love.graphics.draw(l_paddle.sprite, x - l_paddle.bBox.radius, y - l_paddle.bBox.radius)
		--l_paddle.bBox.draw()
	end

	function l_paddle.intersects(bCircle)
		return l_paddle.bBox.cIntersects(bCircle)
	end

	return l_paddle
end
