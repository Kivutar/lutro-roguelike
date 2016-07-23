require "collisions"

local bubble = {}
bubble.__index = bubble

function newBubble(object)
	local n = object
	n.type = "bubble"
	n.width = 16
	n.height = 16
	if n.direction == "left" then
		n.xspeed = -3
		n.xaccel = 0.05
	else
		n.xaccel = -0.05
		n.xspeed = 3
	end
	n.yspeed = 0
	n.yaccel = -0.01
	n.die = -1

	n.img = lutro.graphics.newImage("assets/bubble.png")
	n.img_explode = lutro.graphics.newImage("assets/bubble_explode.png")

	return setmetatable(n, bubble)
end

function bubble:update(dt)
	self.xspeed = self.xspeed + self.xaccel
	self.yspeed = self.yspeed + self.yaccel

	if self.direction == "left" and self.xspeed > 0 then
		self.xspeed = 0
	end
	if self.direction == "right" and self.xspeed < 0 then
		self.xspeed = 0
	end
	self.x = self.x + self.xspeed
	--self.y = self.y + self.yspeed

	if self.xspeed == 0 and self.die == -1 then
		self.die = 5
	end

	if self.die > 0 then
		self.die = self.die - 1
		if self.die <= 0 then
			for i=1, #entities do
				if entities[i] == self then
					table.remove(entities, i)
				end
			end
		end
	end
end

function bubble:draw()
	if self.die == -1 then
		lutro.graphics.draw(self.img, self.x, self.y)
	else
		lutro.graphics.draw(self.img_explode, self.x, self.y)
	end
end

function bubble:on_collide(e1, e2, dx, dy)
	if e2.type == "ground" and self.die == -1 then
		-- if math.abs(dy) < math.abs(dx) and dy ~= 0 then
		-- 	self.yspeed = self.yspeed / 2.0
		-- 	self.y = self.y + dy
		-- end

		-- if math.abs(dx) < math.abs(dy) and dx ~= 0 then
		-- 	self.xspeed = self.xspeed / 2.0
		-- 	self.x = self.x + dx
		-- end
		self.xaccel = 0
		self.yaccel = 0
		self.xspeed = 0
		self.yspeed = 0
		self.die = 5
	elseif e2.type == "bubble" and self.die == -1 then
		-- if math.abs(dy) < math.abs(dx) and dy ~= 0 then
		-- 	self.yspeed = 0
		-- 	self.y = self.y + dy
		-- end

		-- if math.abs(dx) < math.abs(dy) and dx ~= 0 then
		-- 	self.xspeed = 0
		-- 	self.x = self.x + dx
		-- end
		-- e2.xspeed = e2.xspeed + self.xspeed / 2.0
		-- e2.yspeed = e2.yspeed + self.yspeed / 2.0
		-- self.yspeed = self.yspeed / 2.0
		-- self.xspeed = self.xspeed / 2.0
		self.xaccel = 0
		self.yaccel = 0
		self.xspeed = 0
		self.yspeed = 0
		self.die = 5
	end
end
