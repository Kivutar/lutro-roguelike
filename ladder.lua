require "collisions"

local ladder = {}
ladder.__index = ladder

function newLadder(object)
	local n = object
	n.y = n.y -1
	n.type = "ladder"
	n.width = 16
	n.height = 17
	n.img = lutro.graphics.newImage("assets/ladder.png")

	return setmetatable(n, ladder)
end

function ladder:update(dt)
end

function ladder:draw()
	lutro.graphics.draw(self.img, self.x, self.y)
end

function ladder:on_collide(e1, e2, dx, dy)
end
