require "collisions"

local fatknight = {}
fatknight.__index = fatknight

function newFatknight(n)
	n.type = "fatknight"
	n.width = 24
	n.height = 32
	n.xspeed = 0
	n.yspeed = 0
	n.xaccel = 0.5
	n.yaccel = 0.17
	n.direction = "left"
	n.stance = "stand"
	n.ATTACKING = 0
	n.speedlimit = 1
	n.behavior = "sleeping"
	n.HIT = 0
	n.GUARD = 0
	n.sword = nil
	n.hp = 100
	n.DIYING = 0
	n.KNOCK = 0
	n.target = false

	n.animations = {
		stand = {
			left  = newAnimation(lutro.graphics.newImage(
				"assets/fatknight_stand_left.png"),  96, 64, 2, 10),
			right = newAnimation(lutro.graphics.newImage(
				"assets/fatknight_stand_right.png"), 96, 64, 2, 10)
		},
		hit = {
			left  = newAnimation(lutro.graphics.newImage(
				"assets/fatknight_hit_left.png"),  96, 64, 2, 60),
			right = newAnimation(lutro.graphics.newImage(
				"assets/fatknight_hit_right.png"), 96, 64, 2, 60)
		},
		run = {
			left  = newAnimation(lutro.graphics.newImage(
				"assets/fatknight_run_left.png"),  96, 64, 1, 10),
			right = newAnimation(lutro.graphics.newImage(
				"assets/fatknight_run_right.png"), 96, 64, 1, 10)
		},
		-- jump = {
		-- 	left  = newAnimation(lutro.graphics.newImage(
		-- 		"assets/fatknight_jump_left.png"),  48, 32, 1, 10),
		-- 	right = newAnimation(lutro.graphics.newImage(
		-- 		"assets/fatknight_jump_right.png"), 48, 32, 1, 10)
		-- },
		fall = {
			left  = newAnimation(lutro.graphics.newImage(
				"assets/fatknight_fall_left.png"),  96, 64, 1, 10),
			right = newAnimation(lutro.graphics.newImage(
				"assets/fatknight_fall_right.png"), 96, 64, 1, 10)
		},
		attack = {
			left  = newAnimation(lutro.graphics.newImage(
				"assets/fatknight_attack_left.png"),  96, 64, 3, 10),
			right = newAnimation(lutro.graphics.newImage(
				"assets/fatknight_attack_right.png"), 96, 64, 3, 10)
		},
		dead = {
			left  = newAnimation(lutro.graphics.newImage(
				"assets/fatknight_dead_left.png"),  96, 64, 3, 10),
			right = newAnimation(lutro.graphics.newImage(
				"assets/fatknight_dead_right.png"), 96, 64, 3, 10)
		},
		knock = {
			left  = newAnimation(lutro.graphics.newImage(
				"assets/fatknight_knock_left.png"),  96, 64, 3, 10),
			right = newAnimation(lutro.graphics.newImage(
				"assets/fatknight_knock_right.png"), 96, 64, 3, 10)
		},
		guard = {
			left  = newAnimation(lutro.graphics.newImage(
				"assets/fatknight_guard_left.png"),  96, 64, 3, 10),
			right = newAnimation(lutro.graphics.newImage(
				"assets/fatknight_guard_right.png"), 96, 64, 3, 10)
		},
	}

	n.anim = n.animations[n.stance][n.direction]

	return setmetatable(n, fatknight)
end

function fatknight:on_the_ground()
	return solid_at(self.x + 8, self.y + 32, self)
		or solid_at(self.x + 22, self.y + 32, self)
end

function fatknight:distance(ch)
	local dX = (self.x + self.width/2) - (ch.x + ch.width/2)
	local dY = (self.y + self.height/2) - (ch.y + ch.height/2)
	return math.sqrt( ( dX^2 ) + ( dY^2 ) )
end

function fatknight:update(dt)
	local otg = self:on_the_ground()

	if self.hp <= 0 and otg and self.HIT == 0 then
		self.xspeed = 0
		self.behavior = "sleeping"
		self.target = false
		self.DIYING = self.DIYING + 1
	end

	-- gravity
	if not otg then
		self.yspeed = self.yspeed + self.yaccel
		if (self.yspeed > 3) then self.yspeed = 3 end
		self.y = self.y + self.yspeed
	end

	-- apply speed
	self.x = self.x + self.xspeed;

	if self:distance(character1) < 96 and self.ATTACKING == 0 and self.HIT == 0 and self.GUARD == 0
	and self.hp > 0 and self.KNOCK == 0 and character1.hp > 0 then
		self.behavior = "follow"
		self.target = character1
	end

	if self:distance(character2) < 96 and self.ATTACKING == 0 and self.HIT == 0 and self.GUARD == 0
	and self.hp > 0 and self.KNOCK == 0 and character2.hp > 0 then
		self.behavior = "follow"
		self.target = character2
	end

	if self.target and self:distance(self.target) > 256 and self.HIT == 0 and self.GUARD == 0
	and self.ATTACKING == 0 and self.KNOCK == 0 then
		self.behavior = "sleeping"
		self.target = false
	end

	if self.target and self:distance(self.target) < 42 and self.HIT == 0 and self.GUARD == 0
	and self.ATTACKING == 0 and self.hp > 0 and self.KNOCK == 0 and self.target.hp > 0 then
		self.behavior = "attacking"
		self.ATTACKING = 70
		self.xspeed = 0
	end

	if self.ATTACKING == 40 then
		for i=1, #entities do
			if entities[i] == self.sword then
				table.remove(entities, i)
			end
		end

		self.sword = newFatknightsword({holder = self})
		table.insert(entities, self.sword)

		sfx_sword:play()
	end

	if self.ATTACKING == 38 then
		for i=1, #entities do
			if entities[i] == self.sword then
				table.remove(entities, i)
			end
		end
	end

	if self.behavior == "follow" and self.HIT == 0 and self.GUARD == 0 and self.ATTACKING == 0 then
		if (self.x-self.width/2) - (self.target.x-self.target.width/2) > 0 then
			self.direction = "left"
			self.xspeed = -0.75
		else
			self.direction = "right"
			self.xspeed = 0.75
		end
	end

	if self.HIT > 0 or self.GUARD > 0 then
		if self.xspeed > 0 then
			self.xspeed = self.xspeed - 0.05
			if self.xspeed < 0 then
				self.xspeed = 0
			end
		elseif self.xspeed < 0 then
			self.xspeed = self.xspeed + 0.05;
			if self.xspeed > 0 then
				self.xspeed = 0
			end
		end
	end

	-- animations
	if self.DIYING > 0 then
		self.stance = "dead"
	elseif self.KNOCK > 0 then
		self.stance = "knock"
	elseif self.HIT > 0 then
		self.stance = "hit"
	elseif self.GUARD > 0 then
		self.stance = "guard"
	elseif self.ATTACKING > 0 then
		self.stance = "attack"
	elseif self:on_the_ground() then
		if self.xspeed == 0 then
			self.stance = "stand"
		else
			self.stance = "run"
		end
	else
		if self.yspeed > 0 then
			self.stance = "fall"
		-- else
		-- 	self.stance = "jump"
		end
	end

	local anim = self.animations[self.stance][self.direction]
	-- always animate from first frame
	if anim ~= self.anim then
		anim.timer = 0
	end
	self.anim = anim;

	self.anim:update(dt)

	if self.ATTACKING > 0 then
		self.ATTACKING = self.ATTACKING - 1
	end

	if self.HIT > 0 then
		self.HIT = self.HIT - 1
	end

	if self.GUARD > 0 then
		self.GUARD = self.GUARD - 1
	end

	if self.KNOCK > 0 then
		self.KNOCK = self.KNOCK - 1
	end

	solid_collisions(self)
end

function fatknight:draw()
	self.anim:draw(self.x-32-4, self.y-32)
end

function fatknight:cancel_attack()
	self.ATTACKING = 0
	for i=1, #entities do
		if entities[i] == self.sword then
			table.remove(entities, i)
		end
	end
end

function fatknight:on_collide(e1, e2, dx, dy)
	if e2.type == "ground" then
		if math.abs(dy) < math.abs(dx) and dy ~= 0 then
			self.yspeed = 0
			self.y = self.y + dy
			if dy < -1 and not self.using_ladder then
				sfx_step:play()
			end
		end

		if math.abs(dx) < math.abs(dy) and dx ~= 0 then
			self.xspeed = 0
			self.x = self.x + dx
		end
	elseif e2.type == "sword" and self.HIT == 0 and self.GUARD == 0 and self.hp > 0 then
		local dmg = 18
		if self.direction == e2.direction or math.abs(e2.y-self.y) > 8 then
			sfx_fkhit:play()
			self.behavior = "follow"
			self.target = e2.holder
			self.HIT = 32
			self:cancel_attack()
			if self.target.x < self.x then
				self.xspeed = 2
			else
				self.xspeed = -2
			end
			if self.target.direction == self.direction then
				dmg = dmg * 1.5
			end
			self.hp = self.hp - dmg
			table.insert(effects, newNotif({x=self.x, y=self.y, text=dmg}))
			if self.hp <= 0 then
				sfx_fatknightdie:play()
			end
		else
			self.GUARD = 16
			self:cancel_attack()
			if self.target.x < self.x then
				self.xspeed = 1
			else
				self.xspeed = -1
			end
			sfx_shield:play()
		end
	elseif e2.type == "magicarrow" and self.HIT == 0 and self.GUARD == 0 and self.hp > 0 then
		local dmg = 22
		if self.direction == e2.direction or math.abs(e2.y-self.y) < 16 then
			sfx_fkhit:play()
			self.behavior = "follow"
			self.target = e2.holder
			self.HIT = 32
			self:cancel_attack()
			if self.target.x < self.x then
				self.xspeed = 2
			else
				self.xspeed = -2
			end
			if self.target.direction == self.direction then
				dmg = dmg * 1.5
			end
			self.hp = self.hp - dmg
			table.insert(effects, newNotif({x=self.x, y=self.y, text=dmg}))
			if self.hp <= 0 then
				sfx_fatknightdie:play()
			end
		else
			self.GUARD = 16
			self:cancel_attack()
			if self.target.x < self.x then
				self.xspeed = 1
			else
				self.xspeed = -1
			end
			sfx_shield:play()
		end
	end
end
