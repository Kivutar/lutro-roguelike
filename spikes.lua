require "collisions"

local spikes = {}
spikes.__index = spikes

function newSpikes(object)
	local n = object
	n.type = "spikes"
	n.width = 16
	n.height = 8

	return setmetatable(n, spikes)
end

function spikes:draw()
	lutro.graphics.draw(IMG_spikes, self.x, self.y-8)
end

function spikes:on_collide(e1, e2, dx, dy)
	if (e2.type == "character" or e2.type == "fatknight") and e2.yspeed > 0 and e2.hp > 0 then
		e2.hp = 0
		e2.xspeed = 0
		table.insert(effects, newNotif({x=self.x, y=self.y, text="999", font=fnt_numbers_red}))
	end
end
