require "collisions"

local titlescreen = {}
titlescreen.__index = titlescreen

function newTitlescreen()
	local n = {}
	n.selecter = newAnimation(IMG_selecter,  48, 48, 2, 10)
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
	local JOY_1_LEFT  = lutro.joystick.isDown(1, RETRO_DEVICE_ID_JOYPAD_LEFT)
	local JOY_1_RIGHT = lutro.joystick.isDown(1, RETRO_DEVICE_ID_JOYPAD_RIGHT)
	local JOY_1_A = lutro.joystick.isDown(1, RETRO_DEVICE_ID_JOYPAD_A)

	if JOY_1_LEFT  then GO_LEFT  = GO_LEFT  + 1 else GO_LEFT  = 0 end
	if JOY_1_RIGHT then GO_RIGHT = GO_RIGHT + 1 else GO_RIGHT = 0 end
	if JOY_1_A     then CONFIRM  = CONFIRM  + 1 else CONFIRM  = 0 end

	if GO_RIGHT == 1 and self.index < 3 then
		self.index = self.index + 1
		sfx_select:play()
	end

	if GO_LEFT == 1 and self.index > 0 then
		self.index = self.index - 1
		sfx_select:play()
	end

	if CONFIRM == 1 then
		if self.index == 0 or self.index == 2 then
			sfx_confirm:play()
			generate_map(self.classes[self.index])
			character1 = newCharacter({x=(start[2]-1)*8*16+64-8, y=48, class=self.classes[self.index], pad=1})
			character2 = newCharacter({x=(start[2]-1)*8*16+64-8, y=48, class="enchanter", pad=2})
			table.insert(entities, character1)
			lifebar1 = newLifeBar({ch = character1, align="left"})
			if character2 then
				table.insert(entities, character2)
				lifebar2 = newLifeBar({ch = character2, align="right"})
			end
			entities_remove(self)
			camera_x = - character1.x + SCREEN_WIDTH/2 - character1.width/2
			camera_y = - character1.y + SCREEN_HEIGHT/2 - character1.height/2
		else
			sfx_wrong:play()
		end
	end

	self.selecter:update(dt)
end

function titlescreen:draw()
	lutro.graphics.draw(IMG_title)
	self.selecter:draw(80 + self.index*32, 144)
end

