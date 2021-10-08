require "collisions"

local gold = {}
gold.__index = gold

function newGold(object)
	local n = object
	n.width = 8
	n.height = 8

	return setmetatable(n, gold)
end

function gold:draw()
	lutro.graphics.draw(IMG_gold, self.x, self.y)
end

function gold:on_collide(e1, e2, dx, dy)
	if e2.type == "character" then
		sfx_gold:play()
		entities_remove(self)
		return
	end
end
