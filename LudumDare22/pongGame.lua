require "boundingBox"
require "paddle"
require "ball"
require "timers"
require "timerScale"

function newPongGame()
	local pong = {}

	pong.background = nil
	pong.paddleHeight = 150
	pong.paddleWidth = 10
	pong.ballRadius = 20
	pong.scaleWidth = 264
	pong.scaleHeight = 34
	pong.minXBound = 75
	pong.minYBound = 182
	pong.maxXBound = 600
	pong.maxYBound = 478
	pong.xOffset = pong.minXBound + 30
	pong.yOffset = love.graphics.getHeight() / 2 - pong.paddleHeight / 2

	pong.paddle = newPaddle("assets/pong_paddle.png")
	pong.ball = newBall("assets/pong_dot.png")
	pong.timer = newTimer(10)
	pong.scale = newTimerScale()

	function pong.init()
		pong.background = love.graphics.newImage("assets/pong_bg.png")

		pong.paddle.init()
		pong.paddle.setPosition(pong.xOffset, pong.yOffset)
		pong.paddle.setBounds(pong.minYBound, pong.maxYBound)

		pong.ball.setBounds(pong.minXBound, pong.maxXBound, pong.minYBound, pong.maxYBound)
		pong.ball.init()

		timerManager.addTimer(pong.timer)
		pong.timer.start()

		pong.scale.init()
		pong.scale.setWidth(pong.scaleWidth)
		pong.scale.setHeight(pong.scaleHeight)
		pong.scale.setPosition(278, 128)
	end

	function pong.draw()
		love.graphics.draw(pong.background, 0, 0)
		pong.paddle.draw()
		pong.ball.draw()
		pong.scale.draw()
		--love.graphics.print("Mouse pos = " .. love.mouse.getX() .. love.mouse.getY(), 50, 50)
		--love.graphics.rectangle("fill", xPos, yPos, paddleWidth, paddleHeight)

	end

	function pong.update(dt)
		pong.paddle.update(dt)
		pong.ball.update(dt)
		pong.timer.update(dt)
		if pong.ball.intersects(pong.paddle.bBox) then
			pong.ball.bounceX()
		end

		--timerManager.update(dt)

		--[[if pong.timer.isTimeUp() then
			pong.timer.restart()
			pong.scale.setWidth(pong.scaleWidth)
		end]]

		pong.scale.update(pong.timer)
	end

	function pong.hasWon()
		local hasWon = pong.timer.isTimeUp()

		return hasWon and not pong.isGameOver()
	end

	function pong.isGameOver()
		return pong.ball.hitGoal
	end

	return pong
end
