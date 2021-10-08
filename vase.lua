require "collisions"

local vase = {}
vase.__index = vase

function newVase(object)
	local n = object
	n.stance = "normal"
	n.width = 16
	n.height = 16

	n.imgs = {}
	n.imgs.normal = IMG_vase
	n.imgs.broken = IMG_vase_broken

	n.img = n.imgs[n.stance]

	return setmetatable(n, vase)
end

function vase:update(dt)
	self.img = self.imgs[self.stance]
end

function vase:draw()
	lutro.graphics.draw(self.img, self.x, self.y)
end

function vase:on_collide(e1, e2, dx, dy)
	if e2.type == "sword" or e2.type == "magicarrow" then
		if self.stance == "normal" then
			lutro.audio.play(sfx_vase)
			for i=0, math.random(0, 1) do
				table.insert(entities, newCoin(
					{x = self.x + self.width/2, y = self.y + self.height / 2}))
			end
		end
		self.stance = "broken"
	end
end
