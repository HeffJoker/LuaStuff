require "boundingBox"
require "cutscene"

function newFacebookGame()
	local face = {}

	face.background = nil
	face.cursor = nil
	face.unClickedButton = nil
	face.clickedButton = nil
	face.buttons = nil
	face.cutscene = nil
	face.transTimer = nil

	function face.init()
		face.background = love.graphics.newImage("assets/facebook_bg.png")
		face.cursor = love.graphics.newImage("assets/facebook_cursor.png")
		face.unClickedButton = love.graphics.newImage("assets/facebook_button_up.png")
		face.clickedButton = love.graphics.newImage("assets/facebook_button_down.png")

		face.transTimer = newTimer(20)

		love.mouse.setVisible(false)
		face.buttons = {}
		face.buttons[1] = {}
		face.buttons[1].clicked = false
		face.buttons[1].bBox = newBoundingBox()
		face.buttons[1].bBox.setPosition(225, 205)
		face.buttons[1].bBox.setWidth(face.unClickedButton:getWidth())
		face.buttons[1].bBox.setHeight(face.unClickedButton:getHeight())

		face.buttons[2] = {}
		face.buttons[2].clicked = false
		face.buttons[2].bBox = newBoundingBox()
		face.buttons[2].bBox.setPosition(225, 345)
		face.buttons[2].bBox.setWidth(face.unClickedButton:getWidth())
		face.buttons[2].bBox.setHeight(face.unClickedButton:getHeight())

		face.buttons[3] = {}
		face.buttons[3].clicked = false
		face.buttons[3].bBox = newBoundingBox()
		face.buttons[3].bBox.setPosition(225, 495)
		face.buttons[3].bBox.setWidth(face.unClickedButton:getWidth())
		face.buttons[3].bBox.setHeight(face.unClickedButton:getHeight())

		face.cutscene = newCutscene()
		face.cutscene.load()
		face.cutscene.addScreen("assets/facebook_astablishing_shot.png", 3)
		face.cutscene.addScreen("assets/facebook_waiting_shot.png", 4)
		face.cutscene.addScreen("assets/facebook_astablishing_shot.png", 2)
		face.cutscene.addScreen("assets/facebook_denied.png", 2)

	end

	function face.update(dt)
		if face.cutscene.isPlaying() then
			face.cutscene.update(dt)
		end

		face.transTimer.update(dt)

		for k, v in pairs(face.buttons) do
			if v.bBox.intersects(love.mouse.getPosition()) then
				if love.mouse.isDown("l") then
					v.clicked = true
					face.transTimer.start()
					break
				end
			end
		end

		if face.transTimer.isTimeUp() and face.transTimer.isRunning then
			face.transTimer.stop()
			face.cutscene.play()
		end
	end

	function face.draw()
		if not face.cutscene.isPlaying() then
			love.graphics.draw(face.background)

			for k,v in pairs(face.buttons) do
				if v.clicked then
					love.graphics.draw(face.clickedButton, v.bBox.getPosition())
				else
					love.graphics.draw(face.unClickedButton, v.bBox.getPosition())
				end
			end

			love.graphics.draw(face.cursor, love.mouse.getPosition())
			love.graphics.setColor(0, 0, 0)
			love.graphics.print("Mouse pos = " .. love.mouse.getX() .. ", " .. love.mouse.getY(), 50, 50)
			love.graphics.setColor(255, 255, 255)
		else
			face.cutscene.draw()
		end
	end

	function face.isGameOver()
		return false
	end

	function face.hasWon()
		return false
	end

	return face
end
