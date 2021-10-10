require "collisions"

local power = {}
power.__index = power

function newPower(object)
	local n = object
	n.stance = "normal"
	n.width = 16
	n.height = 16

	n.imgs = {}
	n.imgs[1] = IMG_vampirecanine
	n.imgs[2] = IMG_potion
	n.imgs[3] = IMG_heart
	n.imgs[4] = IMG_catleg

	n.index = math.random(#n.imgs)
	n.t = 0

	return setmetatable(n, power)
end

function power:update(dt)
	self.t = self.t + 0.2
end

function power:draw()
	lutro.graphics.draw(self.imgs[self.index], self.x, self.y + math.cos(self.t))
end

function power:on_collide(e1, e2, dx, dy)
	if e2.type == "character" and lutro.joystick.isDown(e2.pad, RETRO_DEVICE_ID_JOYPAD_DOWN) then
		sfx_power:play()

		if self.index == 3 then
			e2.maxhp = e2.maxhp + 1
			e2.hp = e2.hp + 1
			sfx_heart:play()
		end

		entities_remove(self)
		return
	end
end
