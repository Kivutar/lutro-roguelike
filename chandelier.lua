require "collisions"

local chandelier = {}
chandelier.__index = chandelier

function newChandelier(object)
	local n = object
	n.type = "chandelier"
	n.width = 16
	n.height = 16
	n.anim = newAnimation(IMG_chandelier, 16, 16, 1, 20)

	return setmetatable(n, chandelier)
end

function chandelier:update(dt)
	self.anim:update(dt)
end

function chandelier:draw()
	self.anim:draw(self.x, self.y)
end
