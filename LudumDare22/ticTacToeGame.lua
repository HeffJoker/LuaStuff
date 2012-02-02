
function newTicTacGame()
	local ticTacToe = {}

	ticTacToe.background = nil
	ticTacToe.xImage = nil
	ticTacToe.oImage = nil
	ticTacToe.currRegion = nil
	ticTacToe.regions = {}
	ticTacToe.currMove = "X"



	function ticTacToe.init()
		local numRegions = 9
		local xStart = 288
		local yStart = 178
		local regionW = 68
		local regionH = regionW
		local margin = 12
		local index = 1

		ticTacToe.background = love.graphics.newImage("assets/tic-tac_bg.png")
		ticTacToe.xImage = love.graphics.newImage("assets/tic-tac_X.png")
		ticTacToe.oImage = love.graphics.newImage("assets/tic-tac_O.png")

		for i=1, math.sqrt(numRegions) do
			for j=1, math.sqrt(numRegions) do
				index = j + ((i-1) * 3)
				ticTacToe.regions[index] = {}
				ticTacToe.regions[index].bBox = newBoundingBox()
				ticTacToe.regions[index].bBox.setPosition(xStart + (regionW + margin) * (j-1),
					yStart + (regionH + margin) * (i-1))
				ticTacToe.regions[index].bBox.setWidth(regionW)
				ticTacToe.regions[index].bBox.setHeight(regionH)
				ticTacToe.regions[index].bBox.setColor(0, 255, 0, 255)

				ticTacToe.regions[index].filled = false
				ticTacToe.regions[index].move = nil
			end

		end
	end

	function ticTacToe.update(dt)
		for k,v in pairs(ticTacToe.regions) do
			if v.bBox.intersects(love.mouse.getPosition()) then
				ticTacToe.currRegion = v
				break
				--v.bBox.setDrawMode("fill")
			else
				--v.bBox.setDrawMode("line")
				ticTacToe.currRegion = nil
			end
		end

		if love.mouse.isDown("l") then
			if ticTacToe.currRegion ~= nil and not ticTacToe.currRegion.filled then
				ticTacToe.currRegion.move = ticTacToe.currMove
				ticTacToe.currRegion.filled = true

				if ticTacToe.currMove == "X" then
					ticTacToe.currMove = "O"
				else
					ticTacToe.currMove = "X"
				end
			end
		end
	end


	function ticTacToe.draw()
		love.graphics.draw(ticTacToe.background, 0, 0)
		--love.graphics.print("Mouse pos = " .. love.mouse.getX() .. love.mouse.getY(), 50, 50)

		if ticTacToe.currRegion ~= nil then
			ticTacToe.drawRegion(ticTacToe.currRegion)
		end

		for k,v in pairs(ticTacToe.regions) do
			ticTacToe.drawRegion(v)
		end
	end

	function ticTacToe.drawRegion(region)
		local xMargin = 0.15
		local yMargin = 0.20

		if region.move == "X" then
			love.graphics.draw(ticTacToe.xImage,
				region.bBox.pos.x + region.bBox.getWidth() * xMargin,
				region.bBox.pos.y + region.bBox.getHeight() * yMargin)
		elseif region.move == "O" then
			love.graphics.draw(ticTacToe.oImage,
				region.bBox.pos.x + region.bBox.getWidth() * xMargin,
				region.bBox.pos.y + region.bBox.getHeight() * yMargin)
		end
	end

	function ticTacToe.isGameOver()
		local regs = ticTacToe.regions

		-- Check rows
		local gameOver = (regs[1].move == regs[2].move and regs[1].move == regs[3].move and regs[1].move ~= nil)
			or (regs[4].move == regs[5].move and regs[4].move == regs[6].move and regs[4].move ~= nil)
			or (regs[7].move == regs[8].move and regs[7].move == regs[9].move and regs[7].move ~= nil)

		-- Check columns
		gameOver = gameOver or (regs[1].move == regs[4].move and regs[1].move == regs[7].move and regs[1].move ~= nil)
			or (regs[2].move == regs[5].move and regs[2].move == regs[8].move and regs[2].move ~= nil)
			or (regs[3].move == regs[6].move and regs[3].move == regs[9].move and regs[3].move ~= nil)

		-- Check diagonals
		gameOver = gameOver or (regs[1].move == regs[5].move and regs[1].move == regs[9].move and regs[1].move ~= nil)
			or (regs[3].move == regs[5].move and regs[3].move == regs[7].move and regs[3].move ~= nil)

		return gameOver
	end

	function ticTacToe.hasWon()
		local hasWon = true

		for k, v in pairs(ticTacToe.regions) do
			hasWon = hasWon and v.filled
		end

		return (hasWon and not ticTacToe.isGameOver())
	end


	return ticTacToe
end
