if not lutro then
	lutro = love
	compat = false
else
	compat = true
end

require "global"
require "anim"
require "character"
require "gold"
require "lader"
require "ground"
require "fatknight"
require "bubble"
require "spikes"
require "sword"
require "fatknightsword"
require "lifebar"
require "vase"
require "treasure"
require "blood"
require "coin"
require "web"
require "stalag"
require "magicarrow"
require "sparkle"
require "chandelier"
require "titlescreen"
require "power"
require "notif"
require "door"
require "fly"

function lutro.conf(t)
	t.width  = SCREEN_WIDTH
	t.height = SCREEN_HEIGHT
end

blocks = {
	{ -- start
		{
			{0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0},
			{0,0,0,1,1,0,0,0},
			{0,0,0,1,1,0,2,0},
			{0,0,1,1,1,1,2,0},
			{1,1,1,0,0,0,2,0},
		},
		{
			{0,0,0,0,0,0,1,1},
			{0,0,0,0,0,0,1,1},
			{0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,2,0},
			{0,0,1,1,1,1,2,0},
			{0,0,1,1,1,1,2,0},
			{0,0,0,0,0,0,2,0},
			{0,0,0,0,0,0,2,0},
		},
		{
			{0,0,0,0,0,0,1,1},
			{0,0,0,1,1,1,1,1},
			{0,0,0,0,0,1,1,0},
			{0,2,0,0,0,1,1,0},
			{0,2,1,1,1,1,1,0},
			{0,2,1,1,1,1,1,0},
			{0,2,0,0,0,0,0,0},
			{0,2,0,0,0,0,0,0},
		},
	},
	{ -- corridor
		{
			{1,1,1,1,1,1,1,1},
			{1,1,1,1,1,1,1,1},
			{0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0},
			{0,0,0,4,0,0,0,0},
			{0,0,0,0,0,0,0,0},
			{1,1,1,1,1,1,1,1},
			{1,1,1,1,1,1,1,1},
		},
		{
			{0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0},
			{0,0,0,4,0,0,0,0},
			{0,0,0,0,0,0,0,0},
			{0,0,1,1,1,1,0,0},
			{0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0},
			{1,1,1,1,1,1,1,1},
		},
		{
			{0,0,0,0,0,0,0,0},
			{0,0,1,1,1,1,0,0},
			{0,0,0,0,0,0,0,0},
			{0,2,0,0,0,0,2,0},
			{0,2,1,1,1,1,2,0},
			{0,2,0,0,0,0,2,0},
			{0,2,0,0,0,0,2,0},
			{1,1,1,1,1,1,1,1},
		},
		{
			{0,0,0,0,0,0,0,0},
			{1,1,1,2,2,1,1,1},
			{0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0},
			{1,1,1,2,2,1,1,1},
			{0,0,0,0,0,0,0,0},
			{1,1,1,1,1,1,1,1},
		},
		{
			{1,1,1,1,1,1,1,1},
			{1,1,1,1,1,1,1,1},
			{0,2,0,0,0,0,2,0},
			{0,2,1,1,1,1,2,0},
			{0,2,1,1,1,1,2,0},
			{0,2,0,0,0,0,2,0},
			{1,1,1,1,1,1,1,1},
			{1,1,1,1,1,1,1,1},
		},
		{
			{1,1,1,1,1,1,1,1},
			{1,1,1,1,1,1,1,1},
			{0,0,0,0,0,1,0,0},
			{0,0,1,1,1,1,0,0},
			{0,1,1,1,1,1,0,0},
			{0,0,0,0,0,0,0,0},
			{1,1,1,1,1,1,1,1},
			{1,1,1,1,1,1,1,1},
		},
		{
			{1,1,1,1,1,1,1,1},
			{0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0},
			{0,0,0,4,0,0,0,0},
			{0,0,0,0,0,0,0,0},
			{1,1,1,1,1,1,1,1},
		},
		{
			{1,1,1,1,1,1,1,1},
			{0,1,0,0,0,0,0,0},
			{0,1,0,0,0,0,0,0},
			{0,1,0,0,0,0,2,0},
			{0,1,1,1,1,1,2,0},
			{0,0,0,0,0,0,2,0},
			{0,0,0,0,0,0,2,0},
			{1,1,1,1,1,1,1,1},
		},
		{
			{1,1,1,1,1,1,1,1},
			{0,2,0,1,0,2,0,0},
			{0,2,1,1,1,2,0,0},
			{0,2,0,0,0,2,0,0},
			{0,1,1,1,1,2,0,0},
			{0,0,0,0,0,2,0,0},
			{0,0,0,0,0,2,0,0},
			{1,1,1,1,1,1,1,1},
		},
		{
			{1,1,1,1,1,1,1,1},
			{0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0},
			{0,0,0,1,1,0,0,0},
			{3,3,3,1,1,3,3,3},
			{1,1,1,1,1,1,1,1},
		},
		{
			{1,1,1,1,1,1,1,1},
			{1,1,1,1,1,1,1,1},
			{0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0},
			{0,1,1,1,0,0,0,0},
			{1,1,1,1,1,0,0,0},
			{1,1,1,1,1,1,1,1},
			{1,1,1,1,1,1,1,1},
		},
		{
			{1,1,1,1,1,1,1,1},
			{1,1,1,1,1,1,1,1},
			{0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0},
			{0,0,0,0,0,1,1,0},
			{0,0,0,0,1,1,1,1},
			{1,1,1,1,1,1,1,1},
			{1,1,1,1,1,1,1,1},
		},
		{
			{1,1,1,1,1,1,1,1},
			{1,1,1,1,1,1,1,1},
			{0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0},
			{0,0,0,1,1,0,0,0},
			{1,0,0,1,1,0,0,1},
			{1,1,3,1,1,3,1,1},
			{1,1,1,1,1,1,1,1},
		},
		{
			{1,1,1,1,1,1,1,1},
			{1,1,1,1,1,1,1,1},
			{0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0},
			{0,0,0,0,1,1,1,0},
			{1,1,0,0,1,1,1,1},
			{1,1,1,1,1,1,1,1},
		},
		{
			{1,1,1,1,1,1,1,1},
			{1,1,1,1,1,1,1,1},
			{0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0},
			{0,0,0,0,1,1,1,0},
			{1,1,3,3,1,1,1,1},
			{1,1,1,1,1,1,1,1},
		},
		{
			{1,1,1,1,1,1,1,1},
			{1,1,1,1,1,1,1,1},
			{0,0,0,1,0,0,0,1},
			{0,0,0,0,0,0,0,0},
			{0,0,0,0,0,1,0,0},
			{1,1,0,0,0,1,1,0},
			{1,1,1,0,1,1,1,1},
			{1,1,1,1,1,1,1,1},
		},
	},
	{ -- falling
		{
			{1,1,1,0,0,1,1,1},
			{1,1,1,0,0,1,1,1},
			{0,0,1,0,0,0,0,0},
			{0,0,1,1,0,2,0,0},
			{0,0,0,1,1,2,0,0},
			{0,0,0,0,0,2,0,0},
			{1,1,0,0,0,2,1,1},
			{1,1,0,0,0,2,1,1},
		},
		{
			{1,1,1,0,2,1,1,1},
			{1,1,1,0,2,1,1,1},
			{0,0,0,0,2,1,1,0},
			{0,0,0,0,2,0,0,0},
			{0,0,0,0,2,0,0,0},
			{0,0,0,0,1,1,0,0},
			{1,1,0,0,1,1,1,1},
			{1,1,0,0,0,0,1,1},
		},
		{
			{1,1,1,0,0,1,1,1},
			{1,1,1,0,0,1,1,1},
			{0,0,0,0,0,0,0,0},
			{0,0,2,0,0,0,0,0},
			{0,0,2,1,1,0,0,0},
			{0,0,2,0,0,0,0,0},
			{1,1,2,0,0,0,1,1},
			{1,1,2,0,0,0,1,1},
		},
		{
			{0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0},
		},
		{
			{0,0,0,0,0,0,2,0},
			{0,0,0,0,0,0,2,0},
			{0,1,1,1,1,0,2,0},
			{0,1,0,2,1,0,2,0},
			{0,1,1,2,1,0,2,0},
			{0,0,0,2,0,0,2,0},
			{0,0,0,2,0,0,2,0},
			{0,0,0,2,0,0,2,0},
		},
		{
			{0,0,0,0,0,0,0,0},
			{0,0,0,0,0,2,0,0},
			{0,2,0,0,0,2,0,0},
			{0,2,0,2,0,2,0,0},
			{0,2,0,2,0,2,0,0},
			{0,2,0,2,0,0,0,0},
			{0,0,0,2,0,0,0,0},
			{0,0,0,0,0,0,0,0},
		},
		{
			{2,1,0,1,1,0,1,0},
			{2,1,0,0,0,0,1,0},
			{2,1,0,0,0,0,1,0},
			{2,0,0,1,1,0,1,0},
			{2,0,0,0,0,0,1,1},
			{1,1,2,0,0,0,0,2},
			{0,1,2,1,1,1,1,2},
			{0,1,2,0,0,0,1,2},
		},
		{
			{1,1,0,0,0,0,1,1},
			{1,0,0,0,0,0,0,1},
			{0,0,1,1,1,1,0,0},
			{0,0,1,4,0,1,0,0},
			{0,0,1,0,0,1,0,0},
			{0,0,1,1,1,1,0,0},
			{1,0,0,0,0,0,0,1},
			{1,1,0,0,0,0,1,1},
		},
		{
			{0,0,1,0,0,0,0,0},
			{1,0,0,0,1,1,0,1},
			{1,0,0,0,0,0,0,0},
			{0,0,1,0,0,0,1,0},
			{0,0,0,0,1,0,0,0},
			{0,0,1,0,0,0,0,0},
			{0,0,1,1,0,0,1,0},
			{1,0,0,0,0,1,1,0},
		},
		{
			{0,0,0,0,0,0,0,0},
			{0,1,1,1,0,0,0,0},
			{0,1,0,0,0,0,0,0},
			{0,1,0,0,1,1,1,0},
			{0,1,0,0,0,0,1,0},
			{0,1,1,1,0,0,1,0},
			{0,0,0,0,0,0,1,0},
			{0,0,0,0,1,1,1,0},
		},
		{
			{1,0,0,0,0,0,0,1},
			{1,0,0,0,0,0,0,1},
			{1,0,0,0,0,0,0,1},
			{0,0,0,0,0,0,0,0},
			{0,0,0,2,0,0,0,0},
			{1,1,1,2,0,1,1,1},
			{1,0,0,2,0,0,0,1},
			{1,0,0,2,0,0,0,1},
		},
		{
			{0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0},
			{0,0,1,1,0,0,0,0},
			{0,0,1,1,0,0,0,2},
			{0,0,1,1,1,1,1,2},
			{0,0,1,1,1,1,1,2},
			{0,0,0,0,0,0,0,2},
			{0,0,0,0,0,0,0,2},
		},
		{
			{1,1,1,0,0,1,1,1},
			{1,1,1,0,0,1,1,1},
			{0,0,0,0,0,0,0,1},
			{0,0,0,0,0,0,0,0},
			{0,0,1,1,0,2,0,0},
			{1,1,1,1,0,2,1,0},
			{1,1,0,0,0,2,1,1},
			{1,1,0,0,0,2,1,1},
		},
		{
			{1,1,2,0,0,0,1,1},
			{1,1,2,1,1,0,1,1},
			{1,0,2,1,1,0,0,1},
			{0,0,2,1,1,0,0,0},
			{0,0,2,1,1,0,0,0},
			{1,1,2,1,1,0,1,1},
			{1,1,2,1,1,0,1,1},
			{1,1,2,0,0,0,1,1},
		},
		{
			{1,1,2,0,0,0,1,1},
			{1,1,2,1,1,0,1,1},
			{1,0,2,1,1,0,0,1},
			{0,0,2,1,1,0,0,0},
			{0,0,2,0,1,0,0,0},
			{1,1,2,1,1,0,1,1},
			{1,1,2,1,1,0,1,1},
			{1,1,2,0,0,0,1,1},
		},
		{
			{1,1,0,0,0,2,1,1},
			{1,1,0,1,1,2,1,1},
			{1,0,0,1,1,2,0,1},
			{0,0,0,0,0,2,0,0},
			{0,0,0,0,0,2,0,0},
			{1,1,0,1,1,2,1,1},
			{1,1,0,1,1,2,1,1},
			{1,1,0,0,0,2,1,1},
		},
	},
	{ -- landing
		{
			{1,1,2,0,0,0,1,1},
			{1,1,2,1,1,0,1,1},
			{0,0,2,1,1,0,0,0},
			{0,0,2,1,1,0,0,0},
			{0,0,2,0,0,0,0,0},
			{0,0,2,0,0,0,0,0},
			{1,1,1,1,1,1,1,1},
			{1,1,1,1,1,1,1,1},
		},
		{
			{1,1,0,0,0,0,1,1},
			{1,1,0,0,0,0,1,1},
			{0,0,0,1,1,0,0,0},
			{0,0,0,1,1,0,0,0},
			{0,1,1,1,1,1,1,0},
			{0,0,0,0,0,0,0,0},
			{1,0,0,0,0,0,0,1},
			{1,1,1,1,1,1,1,1},
		},
		{
			{1,1,0,0,0,0,1,1},
			{1,1,0,0,2,0,1,1},
			{1,1,1,0,2,1,1,1},
			{0,0,0,0,2,0,0,0},
			{0,0,0,0,2,0,0,0},
			{0,0,1,1,2,0,0,0},
			{0,0,1,1,2,0,0,0},
			{1,1,1,1,1,1,1,1},
		},
		{
			{0,0,0,0,0,2,0,0},
			{0,0,0,0,0,2,0,0},
			{0,0,0,0,0,2,0,0},
			{0,0,0,1,1,2,0,0},
			{0,0,0,0,0,2,0,0},
			{0,0,0,0,0,2,0,0},
			{1,1,1,1,1,1,1,1},
			{1,1,1,1,1,1,1,1},
		},
		{
			{1,1,0,0,0,2,1,1},
			{1,1,0,1,1,2,1,1},
			{1,0,0,1,1,2,0,1},
			{0,0,0,0,0,2,0,0},
			{0,0,0,0,0,2,0,0},
			{1,1,1,1,1,1,1,1},
			{1,1,0,0,0,0,1,1},
			{1,1,0,1,1,0,1,1},
		},
		{
			{1,1,0,0,0,2,1,1},
			{1,1,1,1,1,2,1,1},
			{0,0,0,1,1,2,1,1},
			{0,0,0,0,0,2,0,0},
			{0,0,0,0,0,2,0,0},
			{1,1,1,1,1,1,1,1},
			{1,1,0,0,0,0,1,1},
			{1,1,0,1,1,0,1,1},
		},
	},
	{ -- end
		{
			{1,1,0,0,0,0,1,1},
			{1,1,0,0,0,0,1,1},
			{0,0,0,6,0,0,0,0},
			{0,0,0,0,0,0,0,0},
			{0,0,0,1,1,0,0,0},
			{0,0,1,1,1,1,0,0},
			{1,1,1,1,1,1,1,1},
			{1,1,1,1,1,1,1,1},
		},
		{
			{1,1,1,1,1,1,1,1},
			{1,1,1,1,1,1,1,1},
			{0,0,0,6,0,0,0,0},
			{0,0,0,0,0,0,0,0},
			{0,0,1,1,1,0,0,0},
			{0,0,1,1,1,0,0,0},
			{1,1,1,1,1,1,1,1},
			{1,1,1,1,1,1,1,1},
		},
		{
			{1,1,1,1,1,1,1,1},
			{0,0,0,0,0,0,0,0},
			{0,0,0,6,0,0,0,0},
			{0,0,0,0,0,0,0,0},
			{0,0,0,1,1,0,0,0},
			{0,0,1,1,1,1,0,0},
			{0,0,1,1,1,1,0,0},
			{1,1,1,1,1,1,1,1},
		},
		{
			{1,1,1,1,1,1,1,1},
			{0,0,0,0,0,0,0,0},
			{0,0,0,6,0,0,0,0},
			{0,0,0,0,0,0,0,0},
			{0,0,0,1,1,0,0,0},
			{0,0,1,1,1,1,0,0},
			{3,3,1,1,1,1,3,3},
			{1,1,1,1,1,1,1,1},
		},
	},
}

function addroom()
	for my=1, 4 do
		for mx=1, 4 do
			rand = math.random(5)
			if (rand == 1 or rand == 2) and current[2] > 1 and plan[current[1]][current[2]-1] == 0 then -- left
				plan[current[1]][current[2]-1] = 2
				--print("added coridor on the left")
				current = {current[1], current[2]-1}
				addroom()
			elseif (rand == 3 or rand == 4) and current[2] < 4 and plan[current[1]][current[2]+1] == 0 then --right
				plan[current[1]][current[2]+1] = 2
				--print("added coridor on the right")
				current = {current[1], current[2]+1}
				addroom()
			elseif rand == 5 and current[1] < 4 and plan[current[1]+1][current[2]] == 0 then -- down
				if plan[current[1]][current[2]] ~= 1 then
					plan[current[1]][current[2]] = 3
				end
				plan[current[1]+1][current[2]] = 4
				--print("added landing")
				current = {current[1]+1, current[2]}
				addroom()
			elseif my == 4 then
				plan[current[1]][current[2]] = 5
			end
		end
	end
end

function lutro.load()
	character = nil
	screen_shake = 0
	camera_x = 0
	camera_y = 0
	lutro.graphics.setBackgroundColor(17, 17, 12)
	tileset = lutro.graphics.newImage("assets/tileset.png")
	tileset:setFilter("nearest", "nearest")
	bg = lutro.graphics.newImage("assets/bg.png")
	bg0 = lutro.graphics.newImage("assets/bg0.png")
	bg1 = lutro.graphics.newImage("assets/bg1.png")
	bg2 = lutro.graphics.newImage("assets/bg2.png")
	titlescreen = lutro.graphics.newImage("assets/title.png")
	font = lutro.graphics.newImageFont("assets/font.png",
		" abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.,!?-+/")
	lutro.graphics.setFont(font)

	sfx_gold = lutro.audio.newSource("assets/gold.wav")
	sfx_vase = lutro.audio.newSource("assets/vase.wav")
	sfx_treasure = lutro.audio.newSource("assets/treasure.wav")
	sfx_male_die = lutro.audio.newSource("assets/male_die.wav")
	sfx_hurt = lutro.audio.newSource("assets/hurt.wav")
	sfx_coin = lutro.audio.newSource("assets/coin.wav")
	sfx_fkhit = lutro.audio.newSource("assets/fkhit.wav")
	sfx_select = lutro.audio.newSource("assets/select.wav")
	sfx_confirm = lutro.audio.newSource("assets/confirm.wav")
	sfx_wrong = lutro.audio.newSource("assets/wrong.wav")
	sfx_power = lutro.audio.newSource("assets/power.wav")
	sfx_heart = lutro.audio.newSource("assets/heart.wav")
	sfx_fatknightdie = lutro.audio.newSource("assets/fatknightdie.wav")
	sfx_knock = lutro.audio.newSource("assets/knock.wav")
	sfx_shield = lutro.audio.newSource("assets/shield.wav")
	sfx_jump = lutro.audio.newSource("assets/jump.wav")
	sfx_step = lutro.audio.newSource("assets/step.wav")
	sfx_sword = lutro.audio.newSource("assets/sword.wav")
	sfx_fly = lutro.audio.newSource("assets/fly.wav")
	sfx_flydie = lutro.audio.newSource("assets/flydie.wav")

	fnt_numbers = lutro.graphics.newImageFont("assets/numbers.png", "0123456789")
	fnt_numbers_yellow = lutro.graphics.newImageFont("assets/numbers_yellow.png", "0123456789")
	fnt_numbers_red = lutro.graphics.newImageFont("assets/numbers_red.png", "0123456789")

	lutro.graphics.setFont(fnt_numbers)

	lutro.graphics.setDefaultFilter("nearest", "nearest")

	math.randomseed(os.time())

	table.insert(entities, newTitlescreen())
end

function generate_map()
	map = {}

	plan = {
		{0,0,0,0,},
		{0,0,0,0,},
		{0,0,0,0,},
		{0,0,0,0,},		
	}
	x = math.random(4)
	plan[1][x] = 1
	start = {1, x}
	print("first room is [" .. start[2] .. "," .. start[1] .. "]")
	current = start
	addroom()

	for my=1, 4 do
		for mx=1, 4 do
			kind = plan[my][mx]
			if kind == 0 then
				kind = 2
			end
			block = blocks[kind][math.random(#blocks[kind])]
			for y=1, #block do
				if not map[(my-1)*8+y] then
					map[(my-1)*8+y] = {}
				end
				for x=1, #block[y] do
					map[(my-1)*8+y][(mx-1)*8+x] = block[y][x]
				end
			end
		end
	end

	for y=1, #map do
		for x=1, #map[y] do
			if y == 1 then map[y][x] = 1 end
			if x == 1 then map[y][x] = 1 end
			if y == #map then map[y][x] = 1 end
			if x == #map[y] then map[y][x] = 1 end
		end
	end

	for y=1, #map do
		for x=1, #map[y] do
			if map[y][x] == 0
			and map[y+1] and map[y+1][x] == 1
			and map[y-1] and map[y-1][x] == 0
			and map[y][x-1] and map[y][x-1] == 0
			and map[y][x+1] and map[y][x+1] == 0 then
				local r = math.random(20)
				if r == 20 then
					table.insert(entities, newVase({x = (x-1)*16, y = (y-1)*16}))
				elseif r == 19 then
					table.insert(entities, newChandelier({x = (x-1)*16, y = (y-1)*16}))
				end
			elseif map[y][x] == 0
			and map[y+1] and map[y+1][x] == 1
			and map[y-1] and map[y-1][x] == 1
			and (map[y][x-1] and map[y][x-1] == 1
			or map[y][x+1] and map[y][x+1] == 1)
			then
				local r = math.random(1)
				if r == 1 then
					table.insert(entities, newTreasure({x = (x-1)*16, y = (y-1)*16}))
				end
			elseif map[y][x] == 0
			and map[y+1] and map[y+1][x] == 0
			and map[y-1] and map[y-1][x] == 1
			and math.random(2) == 2 then
				table.insert(effects, newStalag({x = (x-1)*16, y = (y-1)*16}))
			elseif map[y][x] == 0
			and math.random(40) == 40 then
				table.insert(entities, newFly({x = (x-1)*16, y = (y-1)*16}))
			elseif map[y][x] == 1 then
				table.insert(solids, newGround({x = (x-1)*16, y = (y-1)*16, mapx = x, mapy = y}))
			elseif map[y][x] == 2 then
				table.insert(entities, newLader({x = (x-1)*16, y = (y-1)*16}))
			elseif map[y][x] == 3 then
				table.insert(entities, newSpikes({x = (x-1)*16, y = (y-1)*16}))
			elseif map[y][x] == 4 then
				table.insert(entities, newFatknight({x = (x-1)*16, y = (y-1)*16}))
			elseif map[y][x] == 6 then
				table.insert(entities, newDoor({x = (x-1)*16, y = (y-1)*16}))
			end
		end
	end
end

function lutro.update(dt)
	for i=1, #entities do
		if entities[i] and entities[i].update then
			entities[i]:update(dt)
		end
	end

	for i=1, #effects do
		if effects[i] and effects[i].update then
			effects[i]:update(dt)
		end
	end

	detect_collisions()

	if screen_shake > 0 then
		screen_shake = screen_shake - 1
	end
end

function lutro.draw()

	lutro.graphics.push()

	lutro.graphics.scale(3)

	lutro.graphics.push()

	-- Shake camera if hit
	local shake_x = 0
	local shake_y = 0
	if screen_shake > 0 then
		shake_x = 5*(math.random()-0.5)
		shake_y = 5*(math.random()-0.5)
	end

	lutro.graphics.translate(camera_x + shake_x, camera_y + shake_y)

	if plan then
		for my=1, 4 do
			for mx=1, 4 do
				if plan[my][mx] == 1 or plan[my][mx] == 5 then
					lutro.graphics.draw(bg, (mx-1)*128, (my-1)*128)
				elseif plan[my][mx] == 2 then
					lutro.graphics.draw(bg, (mx-1)*128, (my-1)*128)
				elseif plan[my][mx] == 3 or plan[my][mx] == 4 then
					lutro.graphics.draw(bg, (mx-1)*128, (my-1)*128)
				else
					lutro.graphics.draw(bg, (mx-1)*128, (my-1)*128)
				end
			end
		end
	end

	for i=1, #solids do
		if solids[i].draw then
			solids[i]:draw(dt)
		end
	end

	for i=1, #effects do
		if effects[i].draw then
			effects[i]:draw(dt)
		end
	end

	for i=1, #entities do
		if entities[i].draw then
			entities[i]:draw(dt)
		end
	end

	lutro.graphics.pop()

	if lifebar then
		lifebar:draw()
	end

	-- for my=1, 4 do
	-- 	for mx=1, 4 do
	-- 		if plan[my][mx] == 0 then
	-- 			lutro.graphics.setColor(20, 20, 20)
	-- 		elseif plan[my][mx] == 1 then
	-- 			lutro.graphics.setColor(255, 255, 0)
	-- 		elseif plan[my][mx] == 2 then
	-- 			lutro.graphics.setColor(0, 0, 255)
	-- 		elseif plan[my][mx] == 3 then
	-- 			lutro.graphics.setColor(255, 0, 255)
	-- 		elseif plan[my][mx] == 4 then
	-- 			lutro.graphics.setColor(0, 255, 0)
	-- 		elseif plan[my][mx] == 5 then
	-- 			lutro.graphics.setColor(255, 255, 0)
	-- 		else
	-- 			lutro.graphics.setColor(128, 128, 128)
	-- 		end
	-- 		lutro.graphics.point(mx, my)
	-- 	end
	-- end

	lutro.graphics.pop()
end
