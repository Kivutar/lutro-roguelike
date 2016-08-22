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
require "magicarrow"
require "sparkle"
require "chandelier"

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
			{0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0},
			{0,0,0,1,1,0,0,0},
			{0,0,1,1,1,1,0,0},
			{1,1,1,1,1,1,1,1},
			{1,1,1,1,1,1,1,1},
		},
		{
			{1,1,1,1,1,1,1,1},
			{1,1,1,1,1,1,1,1},
			{0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0},
			{0,0,1,1,1,0,0,0},
			{0,0,1,1,1,0,0,0},
			{1,1,1,1,1,1,1,1},
			{1,1,1,1,1,1,1,1},
		},
	},
}

function addroom()
	for my=1, 4 do
		for mx=1, 4 do
			rand = math.random(5)
			--print("current is [" .. current[2] .. "," .. current[1].. "] and rand is " .. rand)
			-- if     rand == 1 then print("we go left")
			-- elseif rand == 2 then print("we go right")
			-- elseif rand == 3 then print("we go down")
			-- end

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
			--else
				--print("final room")
				--plan[current[1]][current[2]] = 5
				--print("impasse")
				--addroom()
			end
		end
	end
end

function lutro.load()
	camera_x = 0
	camera_y = 0
	lutro.graphics.setBackgroundColor(17, 17, 12)
	tileset = lutro.graphics.newImage("assets/tileset.png")
	bg = lutro.graphics.newImage("assets/bg.png")
	bg0 = lutro.graphics.newImage("assets/bg0.png")
	bg1 = lutro.graphics.newImage("assets/bg1.png")
	bg2 = lutro.graphics.newImage("assets/bg2.png")
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

	math.randomseed(os.time())

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
	--plan[current[2]][current[1]] = 5

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
				table.insert(entities, newTreasure({x = (x-1)*16, y = (y-1)*16}))

			elseif map[y][x] == 0
			and map[y+1] and map[y+1][x] == 0
			and map[y-1] and map[y-1][x] == 1
			and map[y][x-1] and map[y][x-1] == 1
			and map[y][x+1] and map[y][x+1] == 0
			and math.random(3) == 3 then
				table.insert(entities, newWeb({x = (x-1)*16, y = (y-1)*16}))
			elseif map[y][x] == 1 then
				table.insert(entities, newGround({x = (x-1)*16, y = (y-1)*16, mapx = x, mapy = y}))
			elseif map[y][x] == 2 then
				table.insert(entities, newLader({x = (x-1)*16, y = (y-1)*16}))
			elseif map[y][x] == 3 then
				table.insert(entities, newSpikes({x = (x-1)*16, y = (y-1)*16}))
			elseif map[y][x] == 4 then
				table.insert(entities, newFatknight({x = (x-1)*16, y = (y-1)*16}))
			end
		end
	end

	character = newCharacter({x=(start[2]-1)*8*16+64-8, y=48})
	table.insert(entities, character)
	lifebar = newLifeBar()
end

function lutro.update(dt)
	for i=1, #entities do
		if entities[i] and entities[i].update then
			entities[i]:update(dt)
		end
	end
	detect_collisions()
end

function lutro.draw()
	lutro.graphics.push()

	lutro.graphics.translate(camera_x, camera_y)

	for my=1, 4 do
		for mx=1, 4 do
			if plan[my][mx] == 1 or plan[my][mx] == 5 then
				lutro.graphics.draw(bg0, (mx-1)*128, (my-1)*128)
			elseif plan[my][mx] == 2 then
				lutro.graphics.draw(bg1, (mx-1)*128, (my-1)*128)
			elseif plan[my][mx] == 3 or plan[my][mx] == 4 then
				lutro.graphics.draw(bg2, (mx-1)*128, (my-1)*128)
			else
				lutro.graphics.draw(bg1, (mx-1)*128, (my-1)*128)
			end
		end
	end

	for i=1, #entities do
		if entities[i].draw then
			entities[i]:draw(dt)
		end
	end

	lutro.graphics.pop()

	lifebar:draw()

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
end
