local fatknightsword = {}
fatknightsword.__index = fatknightsword

function newFatknightsword(object)
	local n = object
	n.x = n.holder.x - 28
	n.y = n.holder.y - 24
	if n.holder.direction == "right" then
		n.x = n.holder.x + 12
	end
	n.width = 40
	n.height = 56
	n.type = "fatknightsword"

	return setmetatable(n, fatknightsword)
end

function fatknightsword:update(dt)
	self.x = self.holder.x - 28
	self.y = self.holder.y - 24
	if self.holder.direction == "right" then
		self.x = self.holder.x + 12
	end
end

function fatknightsword:draw()
	--lutro.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

