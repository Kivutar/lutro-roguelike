require "collisions"

local character = {}
character.__index = character

function newCharacter()
	local n = {}
	n.type = "character"
	n.width = 12
	n.height = 12
	n.xspeed = 0
	n.yspeed = 0
	n.xaccel = 0.5
	n.yaccel = 0.1
	n.o2     = 100
	n.x = 64
	n.y = 64
	n.direction = "left"
	n.stance = "fall"
	n.DO_JUMP = 0
	n.DO_BUBBLE = 0
	n.speedlimit = 1

	n.animations = {
		stand = {
			left  = newAnimation(lutro.graphics.newImage(
				"assets/test_stand_left.png"),  16, 16, 100, 10),
			right = newAnimation(lutro.graphics.newImage(
				"assets/test_stand_right.png"), 16, 16, 100, 10)
		},
		run = {
			left  = newAnimation(lutro.graphics.newImage(
				"assets/test_run_left.png"),  16, 16, 1, 10),
			right = newAnimation(lutro.graphics.newImage(
				"assets/test_run_right.png"), 16, 16, 1, 10)
		},
		jump = {
			left  = newAnimation(lutro.graphics.newImage(
				"assets/test_jump_left.png"),  16, 16, 1, 10),
			right = newAnimation(lutro.graphics.newImage(
				"assets/test_jump_right.png"), 16, 16, 1, 10)
		},
		fall = {
			left  = newAnimation(lutro.graphics.newImage(
				"assets/test_fall_left.png"),  16, 16, 1, 10),
			right = newAnimation(lutro.graphics.newImage(
				"assets/test_fall_right.png"), 16, 16, 1, 10)
		},
		attached = {
			left  = newAnimation(lutro.graphics.newImage(
				"assets/test_attached_left.png"),  16, 16, 1, 10),
			right = newAnimation(lutro.graphics.newImage(
				"assets/test_attached_right.png"), 16, 16, 1, 10)
		},

	}

	n.anim = n.animations[n.stance][n.direction]
	n.sfx = {
		jump = lutro.audio.newSource("assets/jump.wav"),
		step = lutro.audio.newSource("assets/step.wav")
	}
	return setmetatable(n, character)
end

function character:on_the_ground()
	return solid_at(self.x + 1, self.y + 12, self)
		or solid_at(self.x + 11, self.y + 12, self)
end

function character:attached()
	return (self.direction == "right" and solid_at(self.x + 12, self.y, self) and not solid_at(self.x + 12, self.y -1, self))
	    or (self.direction == "left"  and solid_at(self.x -  1, self.y, self) and not solid_at(self.x -  1, self.y -1, self))
end

function character:update(dt)
	local JOY_LEFT  = lutro.input.joypad("left")
	local JOY_RIGHT = lutro.input.joypad("right")
	local JOY_UP    = lutro.input.joypad("up")
	local JOY_B     = lutro.input.joypad("b")
	local JOY_Y     = lutro.input.joypad("y")
	local JOY_A     = lutro.input.joypad("a")

	self.o2 = self.o2 - 0.05

	if JOY_Y then
		self.speedlimit = 2
	else
		self.speedlimit = 1
	end

	-- gravity
	if not self:on_the_ground() and not self:attached() then
		self.yspeed = self.yspeed + self.yaccel
		if (self.yspeed > 3) then self.yspeed = 3 end
		self.y = self.y + self.yspeed
	end

	-- jumping
	if JOY_B then
		self.DO_JUMP = self.DO_JUMP + 1
	else
		self.DO_JUMP = 0
	end

	-- bubble
	if JOY_A then
		self.DO_BUBBLE = self.DO_BUBBLE + 1
	else
		self.DO_BUBBLE = 0
	end

	if self.DO_BUBBLE == 1 then
		self.o2 = self.o2 - 10
		table.insert(entities, newBubble({ x = self.x, y = self.y - 4, direction = self.direction }))
	end

	if self.DO_JUMP == 1 and (self:on_the_ground() or self:attached()) then
		self.y = self.y - 1
		self.yspeed = -3
		lutro.audio.play(self.sfx.jump)
	end

	-- moving
	if JOY_LEFT then
		self.xspeed = self.xspeed - self.xaccel;
		if self.xspeed < -self.speedlimit then
			self.xspeed = -self.speedlimit
		end
		self.direction = "left";
	end

	if JOY_RIGHT then
		self.xspeed = self.xspeed + self.xaccel;
		if self.xspeed > self.speedlimit then
			self.xspeed = self.speedlimit
		end
		self.direction = "right";
	end

	if JOY_UP and self:attached() then
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
	if  not (JOY_RIGHT and self.xspeed > 0)
	and not (JOY_LEFT  and self.xspeed < 0)
	and self:on_the_ground()
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
	end

	-- animations
	if self:on_the_ground() then
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

	local anim = self.animations[self.stance][self.direction]
	-- always animate from first frame 
	if anim ~= self.anim then
		anim.timer = 0
	end
	self.anim = anim;

	self.anim:update(dt)

	-- camera
	camera_x = - self.x + SCREEN_WIDTH/2 - self.width/2;
	camera_y = - self.y + SCREEN_HEIGHT/2 - self.height/2;

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
end

function character:draw()
	self.anim:draw(self.x-2, self.y-4)
end

function character:on_collide(e1, e2, dx, dy)
	if e1.type == "ground" or e2.type == "ground" then
		if math.abs(dy) < math.abs(dx) and dy ~= 0 then
			self.yspeed = 0
			self.y = self.y + dy
			lutro.audio.play(self.sfx.step)
		end

		if math.abs(dx) < math.abs(dy) and dx ~= 0 then
			self.xspeed = 0
			self.x = self.x + dx
		end
	end
end
