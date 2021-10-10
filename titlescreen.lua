require "collisions"

local titlescreen = {}
titlescreen.__index = titlescreen

function newTitlescreen()
	local n = {}
	n.selecter1 = newAnimation(IMG_selecter1,  48, 48, 2, 60)
	n.selecter2 = newAnimation(IMG_selecter2,  48, 48, 2, 60)
	n.index1 = 0
	n.index2 = 0
	n.confirm1 = 0
	n.confirm2 = 0

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

	local JOY_2_LEFT  = lutro.joystick.isDown(2, RETRO_DEVICE_ID_JOYPAD_LEFT)
	local JOY_2_RIGHT = lutro.joystick.isDown(2, RETRO_DEVICE_ID_JOYPAD_RIGHT)
	local JOY_2_A = lutro.joystick.isDown(2, RETRO_DEVICE_ID_JOYPAD_A)

	if self.confirm1 == 0 then
		if JOY_1_LEFT  then GO_LEFT1  = GO_LEFT1  + 1 else GO_LEFT1  = 0 end
		if JOY_1_RIGHT then GO_RIGHT1 = GO_RIGHT1 + 1 else GO_RIGHT1 = 0 end
		if JOY_1_A     then self.confirm1  = self.confirm1  + 1 else self.confirm1  = 0 end
	end

	if self.confirm2 == 0 then
		if JOY_2_LEFT  then GO_LEFT2  = GO_LEFT2  + 1 else GO_LEFT2  = 0 end
		if JOY_2_RIGHT then GO_RIGHT2 = GO_RIGHT2 + 1 else GO_RIGHT2 = 0 end
		if JOY_2_A     then self.confirm2  = self.confirm2  + 1 else self.confirm2  = 0 end
	end

	if GO_RIGHT1 == 1 and self.index1 < 3 then
		self.index1 = self.index1 + 1
		sfx_select:play()
	end

	if GO_LEFT1 == 1 and self.index1 > 0 then
		self.index1 = self.index1 - 1
		sfx_select:play()
	end

	if GO_RIGHT2 == 1 and self.index2 < 3 then
		self.index2 = self.index2 + 1
		sfx_select:play()
	end

	if GO_LEFT2 == 1 and self.index2 > 0 then
		self.index2 = self.index2 - 1
		sfx_select:play()
	end

	if JOY_1_A or JOY_2_A then sfx_confirm:play() end

	if self.confirm1 == 1 and self.confirm2 == 1 then
		if self.index1 == 0 or self.index1 == 2 then
			sfx_confirm:play()
			generate_map()
			character1 = newCharacter({x=(start[2]-1)*8*16+64-8, y=48, class=self.classes[self.index1], pad=1})
			character2 = newCharacter({x=(start[2]-1)*8*16+64-8, y=48, class=self.classes[self.index2], pad=2})
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

	if self.confirm1 == 1 then self.selecter1.timer = 0 end
	if self.confirm2 == 1 then self.selecter2.timer = 0 end
	self.selecter1:update(dt)
	self.selecter2:update(dt)
end

function titlescreen:draw()
	lutro.graphics.draw(IMG_title)
	self.selecter1:draw(80 + self.index1*32, 144)
	self.selecter2:draw(80 + self.index2*32, 144)
end

