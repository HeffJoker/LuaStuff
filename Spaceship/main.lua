spaceship = nil
xpos, ypos = 0, 0
gravity = 0.5
xvel, yvel = 0, 0

function love.load()
	spaceship = love.graphics.newImage("spaceship.png")
	xpos, ypos = 300, 0
end

function love.update(dt)

	if(love.keyboard.isDown("up")) then
		yvel = yvel - 5
	elseif(love.keyboard.isDown("down")) then
		yvel = yvel + 5
	end

	if(love.keyboard.isDown("left")) then
		xvel = xvel - 5
	elseif(love.keyboard.isDown("right")) then
 		xvel = xvel + 5
	end

	xpos = xpos + xvel
	ypos = ypos + yvel * (gravity)

end


function love.draw()
	love.graphics.draw(spaceship, xpos, ypos)
end



