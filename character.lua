require "collisions"

local character = {}
character.__index = character

function newCharacter(n)
	n.type = "character"
	n.width = 12
	n.height = 16
	n.xspeed = 0
	n.yspeed = 0
	n.xaccel = 0.5
	n.yaccel = 0.17
	n.o2     = 100
	n.direction = "left"
	n.stance = "fall"
	n.DO_JUMP = 0
	n.A_PRESS = 0
	n.A_RELEASE = 0
	n.OLD_A = 0
	n.ATTACKING = 0
	n.speedlimit = 1.5
	n.using_lader = false
	n.sword = nil
	if n.class == "knight" then
		n.hp = 5
		n.oldhp = 5
		n.maxhp = 5
	elseif n.class == "enchanter" then
		n.hp = 3
		n.oldhp = 3
		n.maxhp = 3
	end
	n.HIT = 0
	n.t = 0
	n.vampirism = 0

	n.animations = {
		knight = {
			stand = {
				left  = newAnimation(lutro.graphics.newImage(
					"assets/knight_stand_left.png"),  48, 32, 2, 10),
				right = newAnimation(lutro.graphics.newImage(
					"assets/knight_stand_right.png"), 48, 32, 2, 10)
			},
			run = {
				left  = newAnimation(lutro.graphics.newImage(
					"assets/knight_run_left.png"),  48, 32, 1, 10),
				right = newAnimation(lutro.graphics.newImage(
					"assets/knight_run_right.png"), 48, 32, 1, 10)
			},
			jump = {
				left  = newAnimation(lutro.graphics.newImage(
					"assets/knight_jump_left.png"),  48, 32, 1, 10),
				right = newAnimation(lutro.graphics.newImage(
					"assets/knight_jump_right.png"), 48, 32, 1, 10)
			},
			fall = {
				left  = newAnimation(lutro.graphics.newImage(
					"assets/knight_fall_left.png"),  48, 32, 1, 10),
				right = newAnimation(lutro.graphics.newImage(
					"assets/knight_fall_right.png"), 48, 32, 1, 10)
			},
			attached = {
				left  = newAnimation(lutro.graphics.newImage(
					"assets/knight_attached_left.png"),  48, 32, 1, 10),
				right = newAnimation(lutro.graphics.newImage(
					"assets/knight_attached_right.png"), 48, 32, 1, 10)
			},
			hit = {
				left  = newAnimation(lutro.graphics.newImage(
					"assets/knight_hit_left.png"),  48, 32, 1, 10),
				right = newAnimation(lutro.graphics.newImage(
					"assets/knight_hit_right.png"), 48, 32, 1, 10)
			},
			attack = {
				left  = newAnimation(lutro.graphics.newImage(
					"assets/knight_attack_left.png"),  48, 32, 1, 10),
				right = newAnimation(lutro.graphics.newImage(
					"assets/knight_attack_right.png"), 48, 32, 1, 10)
			},
			lader = {
				left  = newAnimation(lutro.graphics.newImage(
					"assets/knight_lader_left.png"),  48, 32, 2, 10),
				right = newAnimation(lutro.graphics.newImage(
					"assets/knight_lader_right.png"), 48, 32, 2, 10)
			},
			dead = {
				left  = newAnimation(lutro.graphics.newImage(
					"assets/knight_dead_left.png"),  48, 32, 2, 10),
				right = newAnimation(lutro.graphics.newImage(
					"assets/knight_dead_right.png"), 48, 32, 2, 10)
			},
		},
		enchanter = {
			stand = {
				left  = newAnimation(lutro.graphics.newImage(
					"assets/enchanter_stand_left.png"),  48, 32, 2, 10),
				right = newAnimation(lutro.graphics.newImage(
					"assets/enchanter_stand_right.png"), 48, 32, 2, 10)
			},
			run = {
				left  = newAnimation(lutro.graphics.newImage(
					"assets/enchanter_run_left.png"),  48, 32, 1, 10),
				right = newAnimation(lutro.graphics.newImage(
					"assets/enchanter_run_right.png"), 48, 32, 1, 10)
			},
			jump = {
				left  = newAnimation(lutro.graphics.newImage(
					"assets/enchanter_jump_left.png"),  48, 32, 1, 10),
				right = newAnimation(lutro.graphics.newImage(
					"assets/enchanter_jump_right.png"), 48, 32, 1, 10)
			},
			fall = {
				left  = newAnimation(lutro.graphics.newImage(
					"assets/enchanter_fall_left.png"),  48, 32, 1, 10),
				right = newAnimation(lutro.graphics.newImage(
					"assets/enchanter_fall_right.png"), 48, 32, 1, 10)
			},
			attached = {
				left  = newAnimation(lutro.graphics.newImage(
					"assets/enchanter_attached_left.png"),  48, 32, 1, 10),
				right = newAnimation(lutro.graphics.newImage(
					"assets/enchanter_attached_right.png"), 48, 32, 1, 10)
			},
			hit = {
				left  = newAnimation(lutro.graphics.newImage(
					"assets/enchanter_hit_left.png"),  48, 32, 1, 10),
				right = newAnimation(lutro.graphics.newImage(
					"assets/enchanter_hit_right.png"), 48, 32, 1, 10)
			},
			attack = {
				left  = newAnimation(lutro.graphics.newImage(
					"assets/enchanter_attack_left.png"),  48, 32, 2, 10),
				right = newAnimation(lutro.graphics.newImage(
					"assets/enchanter_attack_right.png"), 48, 32, 2, 10)
			},
			lader = {
				left  = newAnimation(lutro.graphics.newImage(
					"assets/enchanter_lader_left.png"),  48, 32, 2, 10),
				right = newAnimation(lutro.graphics.newImage(
					"assets/enchanter_lader_right.png"), 48, 32, 2, 10)
			},
			dead = {
				left  = newAnimation(lutro.graphics.newImage(
					"assets/enchanter_dead_left.png"),  48, 32, 2, 10),
				right = newAnimation(lutro.graphics.newImage(
					"assets/enchanter_dead_right.png"), 48, 32, 2, 10)
			},
		},
	}

	n.anim = n.animations[n.class][n.stance][n.direction]
	n.dotanim = newAnimation(lutro.graphics.newImage(
		"assets/dot.png"), 3, 3, 1, 30)
	n.sfx = {
		jump = lutro.audio.newSource("assets/jump.wav"),
		step = lutro.audio.newSource("assets/step.wav"),
		sword = lutro.audio.newSource("assets/sword.wav"),
	}
	return setmetatable(n, character)
end

function character:on_the_ground()
	return solid_at(self.x + 4, self.y + 16, self)
		or solid_at(self.x + 11, self.y + 16, self)
end

function character:attached()
	return (self.direction == "right" and solid_at(self.x + 15, self.y, self) and not solid_at(self.x + 15, self.y -1, self))
	    or (self.direction == "left"  and solid_at(self.x -  1, self.y, self) and not solid_at(self.x -  1, self.y -1, self))
end

function character:update(dt)
	if compat then
		JOY_LEFT  = lutro.input.joypad("left")
		JOY_RIGHT = lutro.input.joypad("right")
		JOY_UP    = lutro.input.joypad("up")
		JOY_DOWN  = lutro.input.joypad("down")
		JOY_B     = lutro.input.joypad("b")
		JOY_Y     = lutro.input.joypad("y")
		JOY_A     = lutro.input.joypad("a")
	else
		JOY_LEFT  = lutro.keyboard.isDown("left")
		JOY_RIGHT = lutro.keyboard.isDown("right")
		JOY_UP    = lutro.keyboard.isDown("up")
		JOY_DOWN  = lutro.keyboard.isDown("down")
		JOY_B     = lutro.keyboard.isDown("z")
		JOY_Y     = lutro.keyboard.isDown("a")
		JOY_A     = lutro.keyboard.isDown("x")
	end

	self.o2 = self.o2 - 0.05

	if JOY_Y then
		self.speedlimit = 3
	else
		self.speedlimit = 1.5
	end

	-- gravity
	if not self:on_the_ground() and not self:attached() and not self.using_lader then
		self.yspeed = self.yspeed + self.yaccel
		if (self.yspeed > 3) then self.yspeed = 3 end
		self.y = self.y + self.yspeed
	end

	-- jumping
	if JOY_B and self.HIT == 0 and self.hp > 0 then
		self.DO_JUMP = self.DO_JUMP + 1
	else
		self.DO_JUMP = 0
	end

	if self.DO_JUMP == 1 then
		if self:on_the_ground() or self:attached() or self.using_lader then
			self.using_lader = false
			self.y = self.y - 1
			self.yspeed = -3
			lutro.audio.play(self.sfx.jump)
		end
	end

	-- attacking
	if JOY_A and self.HIT == 0 and self.hp > 0 and self.ATTACKING == 0 then
		self.A_PRESS = self.A_PRESS + 1
		self.OLD_A = 1
	else
		if self.OLD_A == 1 then
			self.A_RELEASE = 1
			self.ATTACKING = 32

			if self.class == "knight" then
				for i=1, #entities do
					if entities[i] == self.sword then
						table.remove(entities, i)
					end
				end

				self.sword = newSword({holder = self})
				table.insert(entities, self.sword)
			elseif self.class == "enchanter" then
				table.insert(entities, newMagicarrow({holder = self}))
			end

			lutro.audio.play(self.sfx.sword)
		end
		self.OLD_A = 0
		self.A_PRESS = 0
	end

	if self.ATTACKING > 0 then
		self.ATTACKING = self.ATTACKING - 1
	end
	
	if self.ATTACKING == 16 then
		for i=1, #entities do
			if entities[i] == self.sword then
				table.remove(entities, i)
			end
		end
	end

	-- moving
	if JOY_LEFT and self.HIT == 0 and self.hp > 0 then
		self.xspeed = self.xspeed - self.xaccel;
		if self.xspeed < -self.speedlimit then
			self.xspeed = -self.speedlimit
		end
		if self.ATTACKING == 0 then
			self.direction = "left";
		end
	end

	if JOY_RIGHT and self.HIT == 0 and self.hp > 0 then
		self.xspeed = self.xspeed + self.xaccel;
		if self.xspeed > self.speedlimit then
			self.xspeed = self.speedlimit
		end
		if self.ATTACKING == 0 then
			self.direction = "right";
		end
	end

	if JOY_UP and self:attached() and self.HIT == 0 and self.hp > 0 then
		if self.direction == "right" then
			self.y = self.y - 1
			self.yspeed = -2
			self.xspeed = 1
		else
			self.y = self.y - 1
			self.yspeed = -2
			self.xspeed = -1
		end
	end

	-- apply speed
	self.x = self.x + self.xspeed;

	-- decelerating
	if  ((not JOY_RIGHT and self.xspeed > 0)
	or  (not JOY_LEFT  and self.xspeed < 0))
	and self:on_the_ground()
	and self.HIT == 0
	then
		if self.xspeed > 0 then
			self.xspeed = self.xspeed - 10
			if self.xspeed < 0 then
				self.xspeed = 0;
			end
		elseif self.xspeed < 0 then
			self.xspeed = self.xspeed + 10;
			if self.xspeed > 0 then
				self.xspeed = 0;
			end
		end
	elseif self.HIT > 0 then
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

	if self.HIT % 2 == 1 or self.hp <= 0 then
		table.insert(entities, newBlood({x=self.x+6, y=self.y+8}))
	end

	local lader = object_collide(self, "lader")
	if lader then
		if JOY_UP then
			self.using_lader = true
			self.y = self.y - 1
			self.xspeed = 0
			self.x = lader.x + 2
		elseif JOY_DOWN then
			self.using_lader = true
			self.y = self.y + 1
			self.xspeed = 0
			self.x = lader.x + 2
		end
	else
		self.using_lader = false
	end

	-- animations
	if self.hp <= 0 and self:on_the_ground() then
		self.stance = "dead"
	elseif self.HIT > 0 then
		self.stance = "hit"
	elseif self.using_lader then
		self.stance = "lader"
		if not JOY_UP and not JOY_DOWN then
			self.anim.timer = 0.0
		end
	elseif self.A_PRESS > 0 then
		self.stance = "attack"
		self.anim.timer = 0.0
	elseif self.ATTACKING > 0 then
		self.stance = "attack"
		if self.A_RELEASE == 1 then
			self.anim.timer = 4.0
		end
	elseif self:on_the_ground() then
		if self.xspeed == 0 then
			self.stance = "stand"
		else
			self.stance = "run"
		end
	elseif self:attached() then
		self.stance = "attached"
	else
		if self.yspeed > 0 then
			self.stance = "fall"
		else
			self.stance = "jump"
		end
	end

	local anim = self.animations[self.class][self.stance][self.direction]
	-- always animate from first frame 
	if anim ~= self.anim then
		anim.timer = 0
	end
	self.anim = anim;

	self.anim:update(dt)
	self.dotanim:update(dt)

	-- camera
	new_camera_x = - self.x + SCREEN_WIDTH/2 - self.width/2
	new_camera_y = - self.y + SCREEN_HEIGHT/2 - self.height/2
	camera_x = camera_x + (new_camera_x-camera_x) / 10.0;
	camera_y = camera_y + (new_camera_y-camera_y) / 10.0;

	if camera_x > 0 then
		camera_x = 0
	end
	if camera_y > 0 then
		camera_y = 0
	end

	if camera_x < -(#map[1] * 16) + SCREEN_WIDTH then
		camera_x = -(#map[1] * 16) + SCREEN_WIDTH
	end
	
	if camera_y < -(#map * 16) + SCREEN_HEIGHT then
		camera_y = -(#map * 16) + SCREEN_HEIGHT
	end

	if self.A_RELEASE == 1 then
		self.A_RELEASE = 0
	end

	if self.HIT > 0 then
		self.HIT = self.HIT - 1
	end

	if self.oldhp > 0 and self.hp <= 0 then
		lutro.audio.play(sfx_male_die)
	end
	self.oldhp = self.hp

	self.t = self.t + 0.05
end

function character:draw()
	self.anim:draw(self.x-16-2, self.y-16)

	local ox = -7
	if self.direction == "left" then
		ox = 18
	end

	if self.A_PRESS > 16 then
		for i=1,8 do
			local r = math.max(0, 64 - self.A_PRESS*2)
			local x = math.cos(self.t+i)*r
			local y = math.sin(self.t+i)*r
			self.dotanim:draw(self.x+ox+x-1, self.y+10+y-1)
		end
	end
	if self.A_PRESS > 64 then
		for i=1,12 do
			local r = math.max(6, 128 - self.A_PRESS)
			local x = math.cos(self.t+i)*r
			local y = math.sin(self.t+i)*r
			self.dotanim:draw(self.x+ox+x-1, self.y+10+y-1)
		end
	end
	if self.A_PRESS > 128 then
		for i=1,20 do
			local r = math.max(12, 192 - self.A_PRESS)
			local x = math.cos(self.t+i)*r
			local y = math.sin(self.t+i)*r
			self.dotanim:draw(self.x+ox+x-1, self.y+10+y-1)
		end
	end
end

function character:on_collide(e1, e2, dx, dy)
	if e2.type == "ground" then
		if math.abs(dy) < math.abs(dx) and dy ~= 0 then
			self.yspeed = 0
			self.y = self.y + dy
			if dy < -1 and not self.using_lader then
				lutro.audio.play(self.sfx.step)
			end
		end

		if math.abs(dx) < math.abs(dy) and dx ~= 0 then
			self.xspeed = 0
			self.x = self.x + dx
		end
	elseif e2.type == "fatknightsword" and self.HIT == 0 then
		self.HIT = 32
		if e2.holder.x < self.x then
			self.xspeed = 4
		else
			self.xspeed = -4
		end
		self.y = self.y - 1
		self.yspeed = -2
		self.hp = self.hp - 3
		lutro.audio.play(sfx_hurt)
		screen_shake = 10
	elseif e2.type == "fatknight" then
		self.xspeed = 0
		self.x = self.x + dx
	end
end
