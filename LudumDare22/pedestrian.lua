require "animation"

function newPedestrian(filename)
	local l_ped = {}

	l_ped.animation = newAnimation()
	l_ped.startPos = {x = 0, y = 0}
	l_ped.transPos = {x = 0, y = 0}
	l_ped.endPos = {x = 0, y = 0}
	l_ped.scale = 0.25
	--l_ped.dist = 0
	l_ped.timerToTrans = nil
	l_ped.timerToEnd = nil
	l_ped.state = "start"
	l_ped.active = true

	function l_ped.init()
		l_ped.restart()
		l_ped.animation.load(filename, 2, 4)
		l_ped.animation.setFPS(15)
		l_ped.animation.setLoop(true)

		l_ped.timerToTrans = newTimer(4)
		l_ped.restart()
		--l_ped.timerToEnd = newTimer(3)

	end

	function l_ped.restart()
		l_ped.animation.setPosition(l_ped.startPos.x, l_ped.startPos.y)
		l_ped.timerToTrans.restart()
		l_ped.animation.setScale(l_ped.scale)
		l_ped.timerToTrans.start()
	end

	function l_ped.setStartPos(x, y)
		l_ped.startPos.x = x
		l_ped.startPos.y = y
	end

	function l_ped.setTransPos(x, y)
		l_ped.transPos.x = x
		l_ped.transPos.y = y
	end

	function l_ped.setEndPos(x, y)
		l_ped.endPos.x = x
		l_ped.endPos.y = y
	end

	function l_ped.update(dt)

		l_ped.animation.update(dt)
		l_ped.timerToTrans.update(dt)
		--l_ped.timerToEnd.update(dt)

		local updateTimer = nil
		local pos1, pos2 = nil, nil

		--[[if l_ped.timerToTrans.isTimeUp() then
			l_ped.timerToTrans.stop()
			l_ped.timerToEnd.start()
			updateTimer = l_ped.timerToEnd
			pos1 = l_ped.animation.pos
			pos2 = l_ped.endPos
			l_ped.state = "transition"
		else]]
			updateTimer = l_ped.timerToTrans
			pos1 = l_ped.startPos
			pos2 = l_ped.endPos--.transPos
		--end

		local ratio = updateTimer.getRemainingTime() / updateTimer.getDuration()
		local posX = lerp(pos1.x, pos2.x, 1-ratio)
		local posY = lerp(pos1.y, pos2.y, 1-ratio)

		l_ped.animation.setPosition(posX, posY)
		if l_ped.state == "start" then
			l_ped.animation.setScale(lerp(l_ped.scale, 2.0, 1-ratio))--, l_ped.scale, 2))
		end
	end


	function l_ped.draw()
		l_ped.animation.draw()
		love.graphics.print(l_ped.state, 100, 100)
	end

	return l_ped
end
