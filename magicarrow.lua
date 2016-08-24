require "collisions"

local magicarrow = {}
magicarrow.__index = magicarrow

function newMagicarrow(object)
	local n = object
	n.type = "magicarrow"
	n.width = 8
	n.height = 3
	n.direction = n.holder.direction
	n.x = n.holder.x
	n.y = n.holder.y+8
	n.xspeed = 0
	n.anims = {}
	n.anims.left = newAnimation(lutro.graphics.newImage(
		"assets/magicarrow_left.png"), 8, 3, 1, 30)
	n.anims.right = newAnimation(lutro.graphics.newImage(
		"assets/magicarrow_right.png"), 8, 3, 1, 30)
	n.anim = n.anims[n.direction]
	n.t = 0

	return setmetatable(n, magicarrow)
end

function magicarrow:update(dt)
	self.t = self.t + 1

	if self.direction == "left" then
		self.xspeed = -4
	else
		self.xspeed = 4
	end

	self.x = self.x + self.xspeed
	self.anim:update(dt)

	if self.t >= 15 then
		table.insert(entities, newSparkle({x = self.x-6, y = self.y-6}))
		for i=1, #entities do
			if entities[i] == self then
				table.remove(entities, i)
			end
		end
	end
end

function magicarrow:draw()
	self.anim:draw(self.x, self.y)
end

function magicarrow:on_collide(e1, e2, dx, dy)
	if e2.type == "ground" or e2.type == "fatknight" then
		--lutro.audio.play(sfx_magicarrow)
		table.insert(entities, newSparkle({x = self.x-6, y = self.y-6}))
		for i=1, #entities do
			if entities[i] == self then
				table.remove(entities, i)
			end
		end
	end
end
