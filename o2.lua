require "collisions"

local o2 = {}
o2.__index = o2

function newO2(object)
	local n = object
	n.width = 16
	n.height = 16
	n.img = lutro.graphics.newImage("assets/o2.png")

	return setmetatable(n, o2)
end

function o2:update(dt)
end

function o2:draw()
	lutro.graphics.draw(self.img, self.x, self.y)
end

function o2:on_collide(e1, e2, dx, dy)
	if e2.type == "character" then
		if e2.o2 <= 100 then
			e2.o2 = e2.o2 + 0.5
		end
	end
end
