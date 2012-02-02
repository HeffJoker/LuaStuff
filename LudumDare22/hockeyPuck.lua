require "ball"

function newHockeyPuck(filename)
	local l_puck = newBall(filename)

	l_puck.opGoal = nil
	l_puck.urGoal = nil

	function l_puck.init()
		l_puck.bBox = newBoundingCircle()

		local startForce = newVec2(l_puck.speed, math.random() * l_puck.speed)
		local startPos = newVec2(l_puck.maxX / 2, l_puck.maxY / 2)

		l_puck.physics = newPhysics(startForce, startPos)
		l_puck.physics.setMaxForce(100)
		l_puck.setRadius(l_puck.sprite:getWidth() / 2)
	end

	function l_puck.setGoals(opGoal, urGoal)
		l_puck.opGoal = opGoal
		l_puck.urGoal = urGoal
	end

	function l_puck.setPosition(x, y)
		l_puck.bBox.setCenter(x, y)
	end

	function l_puck.getPosition()
		return l_puck.bBox.center.x, l_puck.bBox.center.y
	end

	function l_puck.setRadius(radius)
		l_puck.bBox.setRadius(radius)
	end

	function l_puck.getRadius()
		return l_puck.bBox.getRadius()
	end

	function l_puck.bounce(x, y)
		local d = findDist(l_puck.bBox.center.x, x, l_puck.bBox.center.y, y)

		xDir = x - l_puck.bBox.center.x
		yDir = y - l_puck.bBox.center.y

		l_puck.physics.applyForce((x / d) / 10, (y / d) / 10)
	end

	function l_puck.hasHitGoal()

	end

	return l_puck
end
