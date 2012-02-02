
timerManager = {}

timerManager.timers = {}

function timerManager.addTimer(timer)
	local numTimers = #timerManager.timers

	timerManager[numTimers] = timer
end

function timerManager.update(dt)
	for i = 1, #timerManager.timers do
		if timerManager.timers[i].isRunning() then
			timerManager.timers[i].update(dt)
		end
	end
end

function timerManager.restartAll()
	for i = 1, #timerManager.timers do
		timerManager.timers[i].restart()
	end
end


function newTimer(initVal)
	local l_timer = {}

	l_timer.length = initVal
	l_timer.currTime = initVal
	l_timer.isRunning = false

	function l_timer.update(dt)
		if l_timer.isRunning then
			l_timer.currTime = l_timer.currTime - dt
		end
	end

	function l_timer.getRemainingTime()
		return l_timer.currTime
	end

	function l_timer.getDuration()
		return l_timer.length
	end

	function l_timer.isTimeUp()
		return (l_timer.currTime <= 0)
	end

	function l_timer.start()
		l_timer.isRunning = true
	end

	function l_timer.stop()
		l_timer.isRunning = false
	end

	function l_timer.isRunning()
		return l_timer.isRunning
	end

	function l_timer.restart()
		l_timer.currTime = l_timer.length
	end

	function l_timer.setDuration(time)
		l_timer.length = time
	end

	return l_timer
end
