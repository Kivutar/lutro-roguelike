local lifebar = {}
lifebar.__index = lifebar

function newLifeBar()
	local n = {}
	n.heart_full  = lutro.graphics.newImage("assets/heart_full.png")
	n.heart_half  = lutro.graphics.newImage("assets/heart_half.png")
	n.heart_empty = lutro.graphics.newImage("assets/heart_empty.png")

	return setmetatable(n, lifebar)
end

function lifebar:draw()
	local hp = character.hp
	for i=1,character.maxhp do
		local heart
		if hp >= 1 then
			heart = self.heart_full
		elseif hp == 0.5 then
			heart = self.heart_half
		else
			heart = self.heart_empty
		end
		lutro.graphics.draw(heart, i * 8, 8)
		hp = hp - 1
	end
end
