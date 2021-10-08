require "collisions"

local fly = {}
fly.__index = fly

function newFly(object)
	local n = object
	n.width = 8
	n.height = 8
	n.xspeed = 0
	n.yspeed = 0
	n.behavior = "random"
	n.anim = newAnimation(IMG_fly, 16, 16, 2, 10)
	n.t = 0
	n.HIT = 0
	n.target = false

	return setmetatable(n, fly)
end

function fly:distance(ch)
	local dX = (self.x + self.width/2) - (ch.x + ch.width/2)
	local dY = (self.y + self.height/2) - (ch.y + ch.height/2)
	return math.sqrt( ( dX^2 ) + ( dY^2 ) )
end

function fly:update(dt)
	self.t = self.t + 1
	self.anim:update(dt)

	if self:distance(character1) < 64 and self.behavior == "random" and character1.hp > 0 and not self.target then
		self.behavior = "follow"
		sfx_fly:play()
		self.target = character1
	end

	if self:distance(character2) < 64 and self.behavior == "random" and character2.hp > 0 and not self.target then
		self.behavior = "follow"
		sfx_fly:play()
		self.target = character2
	end

	if self.behavior == "random" and self.t % 200 == 0 and self.HIT == 0 then
		self.xspeed = math.random(-0.1, 0.1)
		self.yspeed = math.random(-0.1, 0.1)
	elseif self.behavior == "follow" and self.HIT == 0 then
		if self.x < (self.target.x+self.target.width/2-4) then
			self.xspeed = 0.4
		else
			self.xspeed = -0.4
		end

		if self.y < (self.target.y+self.target.height/2-4) then
			self.yspeed = 0.4
		elseif self.y > self.target.y then
			self.yspeed = -0.4
		end
	end

	self.x = self.x + self.xspeed
	self.y = self.y + self.yspeed

	if self.HIT > 0 then
		self.HIT = self.HIT - 1
	end

	if self.HIT == 1 then
		for i=1, #entities do
			if entities[i] == self then
				table.remove(entities, i)
			end
		end
	end

	solid_collisions(self)
end

function fly:draw()
	self.anim:draw(self.x-4, self.y-4)
end

function fly:on_collide(e1, e2, dx, dy)
	if e2.type == "ground" then
		if math.abs(dy) < math.abs(dx) and dy ~= 0 then
			self.yspeed = 0
			self.y = self.y + dy
		end

		if math.abs(dx) < math.abs(dy) and dx ~= 0 then
			self.xspeed = 0
			self.x = self.x + dx
		end
	elseif (e2.type == "sword" or e2.type == "magicarrow") and self.HIT == 0 then
		local dmg = 1
		self.HIT = 32
		if e2.x < self.x then
			self.xspeed = 2
		else
			self.xspeed = -2
		end
		self.behavior = "follow"
		table.insert(effects, newNotif({x=self.x, y=self.y, text=dmg}))
		sfx_flydie:play()
	elseif e2.type == "character" and e2.HIT == 0 and e2.hp > 0 then
		if self.x < e2.x then
			e2.x = e2.x + 1
			self.x = self.x - 1
		else
			e2.x = e2.x - 1
			self.x = self.x + 1
		end
	end
end
