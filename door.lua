require "collisions"

local door = {}
door.__index = door

function newDoor(object)
	local n = object
	n.type = "door"
	n.width = 16
	n.height = 32
	n.img = lutro.graphics.newImage("assets/door.png")

	return setmetatable(n, door)
end

function door:update(dt)
end

function door:draw()
	lutro.graphics.draw(self.img, self.x, self.y)
end

function door:on_collide(e1, e2, dx, dy)
	local JOY_1_DOWN  = lutro.joystick.isDown(1, RETRO_DEVICE_ID_JOYPAD_DOWN)
	local JOY_2_DOWN  = lutro.joystick.isDown(2, RETRO_DEVICE_ID_JOYPAD_DOWN)

	if e2.type == "character" and (JOY_1_DOWN or JOY_2_DOWN) then
		entities = {}
		solids = {}
		effects = {}
		generate_map()
		character1.x = (start[2]-1)*8*16+64-8
		character1.y = 48
		table.insert(entities, character1)
		if character2 then
			character2.x = (start[2]-1)*8*16+64-8
			character2.y = 48
			table.insert(entities, character2)
		end
		camera_x = - character1.x + SCREEN_WIDTH/2 - character1.width/2
		camera_y = - character1.y + SCREEN_HEIGHT/2 - character1.height/2
	end
end
