require "boundingBox"

function newTimerScale()
	local l_scale = {}

	l_scale.outlineBox = nil
	l_scale.innerBox = nil
	l_scale.innerWidth = 0

	function l_scale.init()
		l_scale.outerBox = newBoundingBox()
		l_scale.outerBox.setDrawMode("line")
		l_scale.outerBox.setColor(255, 255, 255, 112)

		l_scale.innerBox = newBoundingBox()
		l_scale.innerBox.setDrawMode("fill")
		l_scale.innerBox.setColor(255, 255, 255, 200)
	end

	function l_scale.setPosition(x, y)
		l_scale.outerBox.setPosition(x, y)
		l_scale.innerBox.setPosition(x, y)
	end

	function l_scale.setWidth(width)
		l_scale.outerBox.setWidth(width)
		l_scale.innerBox.setWidth(width)
		l_scale.innerWidth = width
	end

	function l_scale.setHeight(height)
		l_scale.outerBox.setHeight(height)
		l_scale.innerBox.setHeight(height)
	end

	function l_scale.update(timer)
		ratio = timer.getRemainingTime() / timer.length

		l_scale.innerBox.setWidth(l_scale.innerWidth * ratio)

	end

	function l_scale.draw()
		love.graphics.setLineWidth(love.graphics.getLineWidth() * 3)
		l_scale.outerBox.draw()
		love.graphics.setLineWidth(love.graphics.getLineWidth() / 3)
		l_scale.innerBox.draw()
		--love.graphics.print("ratio = " .. ratio, l_scale.outerBox.pos.x, l_scale.outerBox.pos.y + 5)
	end

	return l_scale
end
