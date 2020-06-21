require "collisions"

local coin = {}
coin.__index = coin

function newCoin(object)
	local n = object
	n.width = 2
	n.height = 2
	n.xspeed = math.random(-4,4)/8.0
	n.yspeed = -math.random(10)/10.0
	n.yaccel = 0.1
	n.img = lutro.graphics.newImage("assets/coin.png")

	return setmetatable(n, coin)
end

function coin:on_the_ground()
	return solid_at(self.x, self.y + 2, self)
end

function coin:update(dt)
	-- gravity
	if not self:on_the_ground() then
		self.yspeed = self.yspeed + self.yaccel
		self.y = self.y + self.yspeed
		self.x = self.x + self.xspeed
	end

	solid_collisions(self)
end

function coin:draw()
	lutro.graphics.draw(self.img, self.x, self.y)
end

function coin:on_collide(e1, e2, dx, dy)
	if e2.type == "ground" then
		if math.abs(dy) < math.abs(dx) and dy ~= 0 then
			self.yspeed = -self.yspeed/2.0
			self.y = self.y + dy
		end
		if math.abs(dy) > math.abs(dx) and dx ~= 0 then
			self.xspeed = -self.xspeed/2.0
			self.x = self.x + dx
		end
	elseif e2.type == "character" and (e2.xspeed ~= 0 or e2.yspeed ~= 0) then
		lutro.audio.play(sfx_coin)
		table.insert(effects, newNotif({x=self.x, y=self.y, text="3", font=fnt_numbers_yellow}))
		for i=1, #entities do
			if entities[i] == self then
				table.remove(entities, i)
			end
		end
	end
end