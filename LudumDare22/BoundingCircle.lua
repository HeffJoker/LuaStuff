function newBoundingCircle()
	local l_circle = {}

	l_circle.center = {x = 0, y = 0}
	l_circle.radius = 0
	l_circle.drawMode = "line"

	function l_circle.setRadius(radius)
		l_circle.radius = radius
	end

	function l_circle.getRadius()
		return l_circle.radius
	end

	function l_circle.setPosition(x, y)
		l_circle.center.x = x
		l_circle.center.y = y
	end

	function l_circle.getPosition()
		return l_circle.center.x, l_circle.center.y
	end

	function l_circle.setDrawMode(mode)
		if mode == "fill" or mode == "line" then
			l_circle.drawMode = mode
		end
	end


	function l_circle.draw()
		local r, g, b, a = love.graphics.getColor()

		love.graphics.setColor(0, 255, 0, 255)
		love.graphics.circle(l_circle.drawMode,
			l_circle.center.x, l_circle.center.y,
			l_circle.radius, 20)

		love.graphics.setColor(r, g, b, a)
	end

	function l_circle.intersects(x, y)
		local d = math.sqrt((x-l_circle.center.x)^2 + (y - l_circle.center.y)^2)

		return  d < l_circle.radius
	end

	function l_circle.cIntersects(c2)
		local r3 = math.sqrt((c2.center.x - l_circle.center.x)^2 + (c2.center.y - l_circle.center.y)^2)

		return (r3 < l_circle.radius + c2.radius)
	end

	return l_circle
end
