require "collisions"

local gold = {}
gold.__index = gold

function newGold(object)
	local n = object
	n.width = 8
	n.height = 8
	n.img = lutro.graphics.newImage("assets/gold.png")

	return setmetatable(n, gold)
end

function gold:update(dt)
end

function gold:draw()
	lutro.graphics.draw(self.img, self.x, self.y)
end

function gold:on_collide(e1, e2, dx, dy)
	if e2.type == "character" then
		sfx_gold:play()
		for i=1, #entities do
			if entities[i] == self then
				table.remove(entities, i)
			end
		end
	end
end
