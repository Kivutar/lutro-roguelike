require "collisions"

local treasure = {}
treasure.__index = treasure

function newTreasure(object)
	local n = object
	n.stance = "normal"
	n.width = 16
	n.height = 16

	n.imgs = {}
	n.imgs.normal = lutro.graphics.newImage("assets/treasure.png")
	n.imgs.open = lutro.graphics.newImage("assets/treasure_open.png")

	n.img = n.imgs[n.stance]

	return setmetatable(n, treasure)
end

function treasure:update(dt)
	self.img = self.imgs[self.stance]
end

function treasure:draw()
	lutro.graphics.draw(self.img, self.x, self.y)
end

function treasure:on_collide(e1, e2, dx, dy)
	if e2.type == "sword" or e2.type == "magicarrow" then
		if self.stance == "normal" then
			lutro.audio.play(sfx_treasure)
			for i=3, math.random(3,6) do
				table.insert(entities, newCoin(
					{x = self.x + self.width/2, y = self.y + self.height / 2}))
			end
		end
		self.stance = "open"
	end
end
