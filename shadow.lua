local shadow = {}
shadow.__index = shadow

function newShadow(object)
	local n = object
	n.type = "shadow"
	n.width = 16
	n.height = 16

	return setmetatable(n, shadow)
end

function shadow:draw()
	lutro.graphics.draw(IMG_shadow, self.x, self.y)
end
