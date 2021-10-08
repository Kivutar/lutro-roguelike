require "collisions"

local bouncer = {}
bouncer.__index = bouncer

function newBouncer(object)
	local n = object
	n.type = "bouncer"
	n.width = 16
	n.height = 16
	n.img = lutro.graphics.newImage("assets/bouncer.png")

	return setmetatable(n, bouncer)
end

function bouncer:draw()
	lutro.graphics.draw(self.img, self.x, self.y)
end
