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
	n.o2     = 100
	n.direction = "left"
	n.stance = "stand"
	n.ATTACKING = 0
	n.speedlimit = 1
	n.behavior = "sleeping"
	n.HIT = 0

	n.animations = {
		stand = {
			left  = newAnimation(lutro.graphics.newImage(
				"assets/fatknight_stand_left.png"),  96, 64, 2, 10),
			right = newAnimation(lutro.graphics.newImage(
				"assets/fatknight_stand_right.png"), 96, 64, 2, 10)
		},
		hit = {
			left  = newAnimation(lutro.graphics.newImage(
				"assets/fatknight_stand_left.png"),  96, 64, 2, 10),
			right = newAnimation(lutro.graphics.newImage(
				"assets/fatknight_stand_right.png"), 96, 64, 2, 10)
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
		-- fall = {
		-- 	left  = newAnimation(lutro.graphics.newImage(
		-- 		"assets/fatknight_fall_left.png"),  48, 32, 1, 10),
		-- 	right = newAnimation(lutro.graphics.newImage(
		-- 		"assets/fatknight_fall_right.png"), 48, 32, 1, 10)
		-- },
		attack = {
			left  = newAnimation(lutro.graphics.newImage(
				"assets/fatknight_attack_left.png"),  96, 64, 2, 10),
			right = newAnimation(lutro.graphics.newImage(
				"assets/fatknight_attack_right.png"), 96, 64, 2, 10)
		},
	}

	n.anim = n.animations[n.stance][n.direction]
	n.sfx = {
		jump = lutro.audio.newSource("assets/jump.wav"),
		step = lutro.audio.newSource("assets/step.wav"),
		sword = lutro.audio.newSource("assets/sword2.wav"),
	}
	return setmetatable(n, fatknight)
end

function fatknight:on_the_ground()
	return solid_at(self.x + 8, self.y + 32, self)
		or solid_at(self.x + 22, self.y + 32, self)
end

function fatknight:update(dt)

	-- gravity
	if not self:on_the_ground() then
		self.yspeed = self.yspeed + self.yaccel
		if (self.yspeed > 3) then self.yspeed = 3 end
		self.y = self.y + self.yspeed
	end

	-- apply speed
	self.x = self.x + self.xspeed;

	local dX = self.x - character.x
    local dY = self.y - character.y
	local distance = math.sqrt( ( dX^2 ) + ( dY^2 ) )

	if distance < 96 and self.ATTACKING == 0 and self.HIT == 0 then
		self.behavior = "follow"
	end

	if distance > 128 and self.HIT == 0 then
		self.behavior = "sleeping"
	end

	if distance < 32 and self.HIT == 0 then
		self.behavior = "attacking"
		self.ATTACKING = 32
		self.xspeed = 0
		lutro.audio.play(self.sfx.sword)
	end

	if self.behavior == "follow" then
		if dX > 0 then
			self.direction = "left"
			self.xspeed = -0.5
		else
			self.direction = "right"
			self.xspeed = 0.5
		end
	end

	if self.HIT > 0 then
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
	if self.HIT > 0 then
		self.stance = "hit"
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
		else
			self.stance = "jump"
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
end

function fatknight:draw()
	self.anim:draw(self.x-32-4, self.y-32)
end

function fatknight:on_collide(e1, e2, dx, dy)
	if e2.type == "ground" then
		if math.abs(dy) < math.abs(dx) and dy ~= 0 then
			self.yspeed = 0
			self.y = self.y + dy
			if not self.using_lader then
				lutro.audio.play(self.sfx.step)
			end
		end

		if math.abs(dx) < math.abs(dy) and dx ~= 0 then
			self.xspeed = 0
			self.x = self.x + dx
		end
	elseif e2.type == "sword" and self.HIT == 0 then
		self.HIT = 32
		if dx > 0 then
			self.xspeed = 2
		else
			self.xspeed = -2
		end
	end
end
