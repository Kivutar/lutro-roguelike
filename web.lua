require "collisions"

local web = {}
web.__index = web

function newWeb(object)
	local n = object
	n.width = 16
	n.height = 16

	return setmetatable(n, web)
end

function web:draw()
	lutro.graphics.draw(IMG_web, self.x, self.y)
end
