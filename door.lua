require "collisions"

local door = {}
door.__index = door

function newDoor(object)
	local n = object
	n.stance = "normal"
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
	if compat then
		JOY_DOWN = lutro.input.joypad("down")
	else
		JOY_DOWN = lutro.keyboard.isDown("down")
	end

	if e2.type == "character" and JOY_DOWN then
		entities = {}
		solids = {}
		generate_map()
		character.x = (start[2]-1)*8*16+64-8
		character.y = 48
		table.insert(entities, character)
	end
end
