local lifebar = {}
lifebar.__index = lifebar

function newLifeBar(object)
	local n = object

	return setmetatable(n, lifebar)
end

function lifebar:draw()
	local hp = self.ch.hp
	for i=1,self.ch.maxhp do
		local heart
		if hp >= 1 then
			heart = IMG_heart_full
		elseif hp == 0.5 then
			heart = IMG_heart_half
		else
			heart = IMG_heart_empty
		end
		if self.align == "left" then
			lutro.graphics.draw(heart, i * 8, 8)
		else
			lutro.graphics.draw(heart, SCREEN_WIDTH - (self.ch.maxhp+1)*8 + i * 8 - 8, 8)
		end
		hp = hp - 1
	end
end
