
function newAnimation()
	local anim = {}

	anim.sheet = nil
	anim.frame = nil
	anim.fps = 0
	anim.spf = 0
	anim.fWidth = 0
	anim.fHeight = 0
	anim.currFrame = 0
	anim.numFrames = 0
	anim.timePassed = 0
	anim.numRows = 0
	anim.numCols = 0
	anim.scale = 1
	anim.isPaused = false
	anim.loop = false
	anim.pos = {x = 0, y = 0}

	anim.load = function(sheetName, rows, cols)
		anim.sheet = love.graphics.newImage(sheetName)
		anim.numFrames = rows * cols
		anim.fWidth = anim.sheet:getWidth() / cols
		anim.fHeight = anim.sheet:getHeight() / rows
		anim.frame = love.graphics.newQuad(0, 0, anim.fWidth, anim.fHeight,
			anim.sheet:getWidth(), anim.sheet:getHeight())
		anim.numRows = rows
		anim.numCols = cols

	end

	anim.setPosition = function(x, y)
		anim.pos.x = x
		anim.pos.y = y
	end

	anim.setFPS = function(fpsVal)
		anim.fps = fpsVal
		anim.spf = 1 / fpsVal
	end

	anim.pause = function()
		anim.isPaused = true
	end

	anim.play = function()
		anim.isPaused = false
	end

	anim.setLoop = function(loop)
		anim.loop = loop
	end

	anim.setScale = function(scale)
		anim.scale = scale
	end

	anim.update = function(dt)

		if not anim.isPaused then--and not anim.loop then
			anim.timePassed = anim.timePassed + dt
		end

		if anim.timePassed >= anim.spf then
			anim.currFrame = anim.currFrame + 1

			if anim.currFrame >= anim.numFrames then
				anim.currFrame = 0
				if not anim.loop then
					anim.pause()
				end
			end

			anim.frame:setViewport((anim.currFrame % anim.numCols) * anim.fWidth,
				(math.floor(anim.currFrame / anim.numCols)) * anim.fHeight,
				anim.fWidth, anim.fHeight)

			anim.timePassed = 0
		end
	end

	anim.draw = function()
		love.graphics.drawq(anim.sheet, anim.frame, anim.pos.x, anim.pos.y, 0, anim.scale, anim.scale)
	end

	return anim
end
