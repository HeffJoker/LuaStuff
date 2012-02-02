require "boundingBox"
require "airHockeyPaddle"
require "hockeyPuck"

function newAirHockeyGame()
	local air = {}

	air.minXBound = 76
	air.minYBound = 135
	air.maxXBound = 723
	air.maxYBound = 465

	air.opGoal = newBoundingBox()
	air.urGoal = newBoundingBox()

	air.background = love.graphics.newImage("assets/table.png")
	air.puck = newHockeyPuck("assets/puck.png")
	air.paddle = newAirHockeyPaddle("assets/paddle.png")


	function air.init()
		local goalWidth = 20
		local goalHeight = 100
		local goalY = 247

		air.opGoal.setWidth(goalWidth)
		air.urGoal.setWidth(goalWidth)
		air.opGoal.setHeight(goalHeight)
		air.urGoal.setHeight(goalHeight)

		air.opGoal.setPosition(air.minXBound - goalWidth, goalY)
		air.urGoal.setPosition(air.maxXBound, goalY)

		air.puck.setBounds(air.minXBound, air.maxXBound, air.minYBound, air.maxYBound)
		air.puck.setSpeed(5)
		air.puck.init()
		air.puck.setGoals(air.opGoal, air.urGoal)

		air.paddle.init()
		air.paddle.setBounds(air.minYBound, air.maxYBound, air.maxXBound / 2, air.maxXBound)
		air.paddle.setPosition(air.maxXBound, air.maxYBound / 2)

		--[[air.opGoal.setDrawMode("fill")
		air.urGoal.setDrawMode("fill")
		air.opGoal.setColor(0, 255, 0, 255)
		air.urGoal.setColor(0, 255, 0, 255)]]
	end

	function air.update(dt)
		air.puck.update(dt)
		air.paddle.update(dt)

		if air.paddle.intersects(air.puck.bBox) then
			--air.puck.setPosition(
			air.puck.bounce(air.paddle.getPosition())
		end
	end

	function air.draw()
		love.graphics.draw(air.background, 0, 0)
		air.puck.draw()
		air.paddle.draw()
		--air.opGoal.draw()
		--air.urGoal.draw()
		--love.graphics.print("Mouse pos = " .. love.mouse.getX() ..", " .. love.mouse.getY(), 50, 50)
		--love.graphics.print("opGoal = " .. air.opGoal.getWidth() ..", " .. air.opGoal.getHeight(), 50, 60)
	end

	function air.isGameOver()
		return urGoal.intersects(puck.bBox.center.pos.x + puck.bBox.radius,
			puck.bBox.center.pos.y + puc.bBox.radius)
	end

	function air.hasWon()
		return opGoal.intersects(puck.bBox.center.pos.x - puck.bBox.radius,
			puck.bBox.center.pos.y - puc.bBox.radius)
	end

	return air
end
