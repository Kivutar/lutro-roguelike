require "collisions"

local blood = {}
blood.__index = blood

function newBlood(object)
	local n = object
	n.width = 2
	n.height = 2
	n.xspeed = math.random(-2,2)/4.0
	n.yspeed = math.random(10)/10.0
	n.yaccel = 0.1

	return setmetatable(n, blood)
end

function blood:on_the_ground()
	return solid_at(self.x, self.y + 1, self)
end

function blood:update(dt)
	-- gravity
	if not self:on_the_ground() then
		self.yspeed = self.yspeed + self.yaccel
		self.y = self.y + self.yspeed
		self.x = self.x + self.xspeed
	end

	solid_collisions(self)
end

function blood:draw()
	if self:on_the_ground() then
		lutro.graphics.draw(IMG_bloodground, self.x, self.y)
	else
		lutro.graphics.draw(IMG_blood, self.x, self.y)
	end
end

function blood:on_collide(e1, e2, dx, dy)
	if e2.type == "ground" then
		if math.abs(dy) < math.abs(dx) and dy ~= 0 then
			self.yspeed = 0
			self.y = self.y + dy
		end
	end
end
