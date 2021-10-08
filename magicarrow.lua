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
	n.anims.left = newAnimation(IMG_magicarrow_left, 8, 3, 1, 30)
	n.anims.right = newAnimation(IMG_magicarrow_right, 8, 3, 1, 30)
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
		table.insert(effects, newSparkle({x = self.x-6, y = self.y-6}))
		entities_remove(self)
		return
	end

	solid_collisions(self)
end

function magicarrow:draw()
	self.anim:draw(self.x, self.y)
end

function magicarrow:on_collide(e1, e2, dx, dy)
	if e2.type == "ground" or (e2.type == "fatknight" and e2.hp > 0) then
		-- sfx_magicarrow:play()
		table.insert(effects, newSparkle({x = self.x-6, y = self.y-6}))
		entities_remove(self)
		return
	end
end
