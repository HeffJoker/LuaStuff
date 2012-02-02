require "timers"

function newCutscene()
	local l_scene = {}

	l_scene.timer = nil
	l_scene.screens = nil
	l_scene.currScreen = 1

	function l_scene.load()
		l_scene.timer = newTimer(5)
		l_scene.screens = {}
	end

	function l_scene.addScreen(filename, dispTime)
		local screen = newScreen(filename)
		screen.setDisplayTime(dispTime)

		l_scene.screens[#l_scene.screens+1] = screen
	end

	function l_scene.update(dt)
		l_scene.timer.update(dt)

		if l_scene.isPlaying() then
			if l_scene.timer.isTimeUp() then
				l_scene.screens[l_scene.currScreen].setVisible(false)
				l_scene.currScreen = l_scene.currScreen + 1

				if l_scene.currScreen <= #l_scene.screens then
					l_scene.screens[l_scene.currScreen].setVisible(true)
					l_scene.timer.setDuration(l_scene.screens[l_scene.currScreen].getDisplayTime())
					l_scene.timer.restart()
				else
					l_scene.stop()
				end
			end
		end
	end

	function l_scene.stop()
		l_scene.timer.stop()
	end

	function l_scene.play()
		l_scene.timer.start()
	end

	function l_scene.isPlaying()
		return l_scene.timer.isRunning
	end

	function l_scene.draw()
		for k, v in pairs(l_scene.screens) do
			if v.isVisible() then
				v.draw()
			end
		end
	end

	return l_scene
end

function newScreen(filename)
	local l_screen = {}

	l_screen.background = love.graphics.newImage(filename)
	l_screen.dispTime = 0
	l_screen.visible = false

	function l_screen.setDisplayTime(time)
		l_screen.dispTime = time
	end

	function l_screen.getDisplayTime()
		return l_screen.dispTime
	end

	function l_screen.setVisible(visible)
		l_screen.visible = visible
	end

	function l_screen.isVisible()
		return l_screen.visible
	end

	function l_screen.draw()
		love.graphics.draw(l_screen.background)
	end

	return l_screen
end
