function newVec2(x, y)
	local vec2 = {}
	vec2.x = x
	vec2.y = y

	vec2.normalize = function()
		local l_vec2 = {}
		local len = 0

		len = math.sqrt((vec2.x*vec2.x) + (vec2.y*vec2.y))

		l_vec2.x = vec2.x / len
		l_vec2.y = vec2.y / len

		return l_vec2
	end

	return vec2
end

newPhysics = function(force, pos)
	local physics = {}
	physics.netForce = force
	physics.position = pos
	physics.maxForce = 2
	physics.drag = 0
	physics.forceMag = 1

	physics.setMaxForce = function(force)
		physics.maxForce = force
	end


	physics.applyForce = function(x, y)
		if(physics.netForce.x < physics.maxForce and
			physics.netForce.x > -physics.maxForce) then
			physics.netForce.x = physics.netForce.x + (physics.forceMag * x)
		end

		if(physics.netForce.y < physics.maxForce and
			physics.netForce.y > -physics.maxForce) then
			physics.netForce.y = physics.netForce.y + (physics.forceMag * y)
		end
	end

	physics.update = function(dt)
		local netForce = physics.netForce

		if(netForce.x > 0) then
			netForce.x = netForce.x - physics.drag
		elseif(netForce.x < 0) then
			netForce.x = netForce.x + physics.drag
		end

		if(netForce.y > 0) then
			netForce.y = netForce.y - physics.drag
		elseif(netForce.y < 0) then
			netForce.y = netForce.y + physics.drag
		end

		physics.position.x = physics.position.x + netForce.x
		physics.position.y = physics.position.y + netForce.y

	end

	physics.getX = function()
		return physics.position.x
	end

	physics.getY = function()
		return physics.position.y
	end

	physics.setPosition = function(x, y)
		physics.position.x, physics.position.y = x, y
	end

	return physics
end
