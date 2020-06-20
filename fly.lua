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
	n.anim = newAnimation(lutro.graphics.newImage(
					"assets/fly.png"), 16, 16, 2, 10)
	n.t = 0
	n.HIT = 0

	return setmetatable(n, fly)
end

function fly:update(dt)
	self.t = self.t + 1
	self.anim:update(dt)

	local dX = (self.x + self.width/2) - (character.x + character.width/2)
	local dY = (self.y + self.height/2) - (character.y + character.height/2)
	local distance = math.sqrt( ( dX^2 ) + ( dY^2 ) )

	if distance < 64 and self.behavior == "random" then
		self.behavior = "follow"
		lutro.audio.play(sfx_fly)
	end

	if self.behavior == "random" and self.t % 200 == 0 and self.HIT == 0 then
		self.xspeed = math.random(-0.1, 0.1)
		self.yspeed = math.random(-0.1, 0.1)
	elseif self.behavior == "follow" and self.HIT == 0 then
		if self.x < (character.x+character.width/2-4) then
			self.xspeed = 0.4
		else
			self.xspeed = -0.4
		end

		if self.y < (character.y+character.height/2-4) then
			self.yspeed = 0.4
		elseif self.y > character.y then
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
		if character.x < self.x then
			self.xspeed = 2
		else
			self.xspeed = -2
		end
		self.behavior = "follow"
		table.insert(effects, newNotif({x=self.x, y=self.y, text=dmg}))
		lutro.audio.play(sfx_flydie)
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