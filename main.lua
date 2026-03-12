function love.load()
	wf = require("library/windfield/windfield")
	world = wf.newWorld(0, 800, false)
	-- sleeping is the gravity not being calculated

	world:addCollisionClass("Platform")
	world:addCollisionClass("Player"--[[, { ignores = { "Platform" } }]])
	world:addCollisionClass("Danger")

	player = world:newRectangleCollider(360, 100, 80, 80, { collision_class = "Player" })
	player:setFixedRotation(true)
	player.speed = 240

	platform = world:newRectangleCollider(250, 400, 300, 100, { collision_class = "Platform" })
	platform:setType("static")

	dangerZone = world:newRectangleCollider(0, 550, 800, 50, { collision_class = "Danger" })
	dangerZone:setType("static")
end

function love.update(dt)
	world:update(dt)

	if player.body then
		local px, py = player:getPosition()
		if love.keyboard.isDown("right") or love.keyboard.isDown("d") then
			player:setX(px + player.speed * dt)
		elseif love.keyboard.isDown("left") or love.keyboard.isDown("a") then
			player:setX(px - player.speed * dt)
		end

		if player:enter("Danger") then
			player:destroy()
		end
	end
end

function love.draw()
	world:draw()
end

function love.keypressed(key)
	if key == "up" or key == "w" then
		player:applyLinearImpulse(0, -6500)
	end
end
