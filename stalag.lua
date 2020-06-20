require "collisions"

local stalag = {}
stalag.__index = stalag

function newStalag(object)
	local n = object
	n.width = 16
	n.height = 16

	local rand = math.random(3)
	if rand == 0 then
		n.img = lutro.graphics.newImage("assets/stalag0.png")
	elseif rand == 1 then
		n.img = lutro.graphics.newImage("assets/stalag1.png")
	elseif rand == 2 then
		n.img = lutro.graphics.newImage("assets/stalag2.png")
	elseif rand == 3 then
		n.img = lutro.graphics.newImage("assets/stalag3.png")
	end

	return setmetatable(n, stalag)
end

function stalag:draw()
	lutro.graphics.draw(self.img, self.x, self.y)
end
