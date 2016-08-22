require "collisions"

local titlescreen = {}
titlescreen.__index = titlescreen

function newTitlescreen()
	local n = {}
	n.bg = lutro.graphics.newImage("assets/title.png")
	n.selecter = newAnimation(lutro.graphics.newImage(
		"assets/selecter.png"),  48, 48, 2, 10)
	n.index = 0

	n.classes = {
		[0] = "knight",
		[1] = "cleric",
		[2] = "enchanter",
		[3] = "archer",
	}

	return setmetatable(n, titlescreen)
end

function titlescreen:update(dt)
	local JOY_LEFT  = lutro.input.joypad("left")
	local JOY_RIGHT = lutro.input.joypad("right")
	local JOY_B = lutro.input.joypad("b")

	if JOY_LEFT  then GO_LEFT  = GO_LEFT  + 1 else GO_LEFT  = 0 end
	if JOY_RIGHT then GO_RIGHT = GO_RIGHT + 1 else GO_RIGHT = 0 end
	if JOY_B     then CONFIRM  = CONFIRM  + 1 else CONFIRM  = 0 end

	if GO_RIGHT == 1 and self.index < 3 then
		self.index = self.index + 1
		lutro.audio.play(sfx_select)
	end

	if GO_LEFT == 1 and self.index > 0 then
		self.index = self.index - 1
		lutro.audio.play(sfx_select)
	end

	if CONFIRM == 1 then
		if self.index == 0 or self.index == 2 then
			lutro.audio.play(sfx_confirm)
			generate_map(self.classes[self.index])
			for i=1, #entities do
				if entities[i] == self then
					table.remove(entities, i)
				end
			end
		else
			lutro.audio.play(sfx_wrong)
		end
	end

	self.selecter:update(dt)
end

function titlescreen:draw()
	lutro.graphics.draw(self.bg)
	self.selecter:draw(80 + self.index*32, 144)
end

function titlescreen:on_collide(e1, e2, dx, dy)

end