require "collisions"

local fish = {}
fish.__index = fish

function newFish(object)
	local n = object
	n.width = 16
	n.height = 16
	n.xspeed = -0.25
	n.img_left = lutro.graphics.newImage("assets/fish_left.png")
	n.img_right = lutro.graphics.newImage("assets/fish_right.png")
	n.img_dead = lutro.graphics.newImage("assets/fish_dead.png")
	n.img_bubble = lutro.graphics.newImage("assets/bubble.png")
	n.dead = false

	return setmetatable(n, fish)
end

function fish:update(dt)
	self.x = self.x + self.xspeed
end

function fish:draw()
	if self.dead then
		lutro.graphics.draw(self.img_dead, self.x, self.y)
		lutro.graphics.draw(self.img_bubble, self.x, self.y)
	else
		if self.xspeed < 0 then
			lutro.graphics.draw(self.img_left, self.x, self.y)
		else
			lutro.graphics.draw(self.img_right, self.x, self.y)
		end
	end
end

function fish:on_collide(e1, e2, dx, dy)
	if e2.type == "ground" then
		if math.abs(dx) < math.abs(dy) and dx ~= 0 then
			self.xspeed = -self.xspeed
			self.x = self.x + dx
		end
	elseif e2.type == "bubble" and not self.dead then
		for i=1, #entities do
			if entities[i] == e2 then
				table.remove(entities, i)
			end
		end
		self.xspeed = 0
		self.dead = true
	end
end