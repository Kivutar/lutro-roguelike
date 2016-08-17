require "collisions"

local lader = {}
lader.__index = lader

function newLader(object)
	local n = object
	n.type = "lader"
	n.width = 16
	n.height = 16
	n.img = lutro.graphics.newImage("assets/lader.png")

	return setmetatable(n, lader)
end

function lader:update(dt)
end

function lader:draw()
	lutro.graphics.draw(self.img, self.x, self.y)
end

function lader:on_collide(e1, e2, dx, dy)
end
