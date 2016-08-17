local sword = {}
sword.__index = sword

function newSword(object)
	local n = object
	n.x = n.holder.x - 14
	n.y = n.holder.y - 12
	if n.holder.direction == "right" then
		n.x = n.holder.x + 6
	end
	n.width = 20
	n.height = 28
	n.type = "sword"

	return setmetatable(n, sword)
end

function sword:update(dt)
	self.x = self.holder.x - 14
	self.y = self.holder.y - 12
	if self.holder.direction == "right" then
		self.x = self.holder.x + 6
	end
end

function sword:draw()
	--lutro.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

function sword:on_collide(e1, e2, dx, dy)
end