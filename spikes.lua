require "collisions"

local spikes = {}
spikes.__index = spikes

function newSpikes(object)
	local n = object
	n.width = 16
	n.height = 16
	n.img = lutro.graphics.newImage("assets/spikes.png")

	return setmetatable(n, spikes)
end

function spikes:update(dt)
end

function spikes:draw()
	lutro.graphics.draw(self.img, self.x, self.y)
end

function spikes:on_collide(e1, e2, dx, dy)
	if e2.type == "character" then

	end
end
