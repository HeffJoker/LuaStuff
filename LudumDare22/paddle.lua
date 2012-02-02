require "boundingBox"

function newPaddle(filename)
	local l_paddle = {}

	l_paddle.bBox = nil
	l_paddle.speed = 10
	l_paddle.sprite = nil
	l_paddle.minX = 0
	l_paddle.minY = 0

	function l_paddle.init()
		l_paddle.sprite = love.graphics.newImage(filename)
		l_paddle.bBox = newBoundingBox()
		--l_paddle.bBox.setDrawMode("fill")
		l_paddle.setWidth(l_paddle.sprite:getWidth())
		l_paddle.setHeight(l_paddle.sprite:getHeight())
	end

	function l_paddle.setPosition(x, y)
		l_paddle.bBox.setPosition(x, y)
	end

	function l_paddle.setWidth(width)
		l_paddle.bBox.setWidth(width)
	end

	function l_paddle.setHeight(height)
		l_paddle.bBox.setHeight(height)
	end

	function l_paddle.getWidth()
		return l_paddle.bBox.width
	end

	function l_paddle.getHeight()
		return l_paddle.bBox.height
	end

	function l_paddle.getPosition()
		return l_paddle.bBox.getPosition()--.pos.x, l_paddle.bBox.pos.y
	end

	function l_paddle.update(dt)
		if love.keyboard.isDown("down") then
			l_paddle.setPosition(l_paddle.bBox.pos.x, l_paddle.bBox.pos.y + l_paddle.speed)
		elseif love.keyboard.isDown("up") then
			l_paddle.setPosition(l_paddle.bBox.pos.x, l_paddle.bBox.pos.y - l_paddle.speed)
		end

		l_paddle.bBox.pos.y = clamp(l_paddle.bBox.pos.y, l_paddle.minY, l_paddle.maxY - l_paddle.bBox.height)
	end

	function l_paddle.draw()
		--l_paddle.bBox.draw()
		love.graphics.draw(l_paddle.sprite, l_paddle.getPosition())
	end

	function l_paddle.setBounds(minY, maxY)
		l_paddle.minY, l_paddle.maxY = minY, maxY
	end

	return l_paddle
end
