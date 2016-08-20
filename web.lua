require "collisions"

local web = {}
web.__index = web

function newWeb(object)
	local n = object
	n.width = 16
	n.height = 16
	n.img = lutro.graphics.newImage("assets/web.png")

	return setmetatable(n, web)
end

function web:draw()
	lutro.graphics.draw(self.img, self.x, self.y)
end
