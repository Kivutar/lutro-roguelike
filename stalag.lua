local stalag = {}
stalag.__index = stalag

function newStalag(object)
	local n = object
	n.width = 16
	n.height = 16

	local rand = math.random(4)
	if rand == 1 then
		n.img = IMG_stalag0
	elseif rand == 2 then
		n.img = IMG_stalag1
	elseif rand == 3 then
		n.img = IMG_stalag2
	elseif rand == 4 then
		n.img = IMG_stalag3
	end

	return setmetatable(n, stalag)
end

function stalag:draw()
	lutro.graphics.draw(self.img, self.x, self.y)
end
