function newBoundingBox()
	local l_box = {}

	l_box.pos = {x = 0, y = 0}
	l_box.width = 0
	l_box.height = 0
	l_box.drawMode = "line"
	l_box.color = {r = 0, g = 0, b = 0, a = 255}

	function l_box.setWidth(width)
		l_box.width = width
	end

	function l_box.setPosition(x, y)
		l_box.pos.x = x
		l_box.pos.y = y
	end

	function l_box.getPosition()
		return l_box.pos.x, l_box.pos.y
	end

	function l_box.getWidth()
		return l_box.width
	end

	function l_box.setHeight(height)
		l_box.height = height
	end

	function l_box.getHeight()
		return l_box.height
	end

	function l_box.setColor(r, g, b, a)
		l_box.color.r = r
		l_box.color.g = g
		l_box.color.b = b
		l_box.color.a = a
	end

	function l_box.setDrawMode(mode)
		if mode == "fill" or mode == "line" then
			l_box.drawMode = mode
		end
	end

	function l_box.draw()
		local r, g, b, a = love.graphics.getColor()

		love.graphics.setColor(l_box.color.r, l_box.color.g, l_box.color.b, l_box.color.a)
		love.graphics.rectangle(l_box.drawMode,
			l_box.pos.x, l_box.pos.y,
			l_box.width, l_box.height)

		love.graphics.setColor(r, g, b, a)
	end

	function l_box.intersects(x, y)
		return ((x >= l_box.pos.x and x <= l_box.pos.x + l_box.width) and
			 (y >= l_box.pos.y and y <= l_box.pos.y + l_box.height))
	end

	function l_box.bIntersects(box)
		return (box.pos.x <= l_box.pos.x  + l_box.getWidth()
			and box.pos.x + box.getWidth() >= l_box.pos.x
			and box.pos.y <= l_box.pos.y + l_box.getHeight()
			and box.pos.y + box.getHeight() >= l_box.pos.y)
	end

	return l_box
end
