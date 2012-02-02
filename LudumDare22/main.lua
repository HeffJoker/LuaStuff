require "minigame"

miniGame = nil

function love.load()
	math.randomseed(os.time())
	miniGame = newMiniGame("Facebook")--EyeContact")--"Tictac4One")--"Hockey4One")--Pong4One")

	miniGame.init()
end

function love.update(dt)
	miniGame.update(dt)

	gameOver = miniGame.isGameOver()
	hasWon = miniGame.hasWon()
end

function love.draw()
	miniGame.draw()
	if gameOver then
		love.graphics.print("YOU LOSE", love.graphics.getWidth() / 2, love.graphics.getHeight() / 2,
			0, 2, 2)
	elseif hasWon then
		love.graphics.print("YOU WIN", love.graphics.getWidth() / 2, love.graphics.getHeight() / 2,
			0, 2, 2)
	end
end


-- Helpers

function clamp(val, min, max)
	if val < min then
		val = min
	elseif val > max then
	end
		val = max

	return val
end

function lerp(val1, val2, weight)
	return val1 * (1 - weight) + val2 * weight
end

function findDist(x1, x2, y1, y2)
	return math.sqrt((x2-x1)^2 + (y2 - y1)^2)
end
