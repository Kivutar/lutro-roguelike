require "collisions"

local ground = {}
ground.__index = ground

function newGround(object)
	local n = object
	n.type = "ground"
	n.width = 16
	n.height = 16

	return setmetatable(n, ground)
end

function ground:draw()

	-- if math.abs(self.x - character.x) > 320 then
	-- 	return
	-- end

	-- if math.abs(self.y - character.y) > 240 then
	-- 	return
	-- end

	-- single
	if  (map[self.mapy  ] and map[self.mapy  ][self.mapx-1] ~= 1)
	and (map[self.mapy  ] and map[self.mapy  ][self.mapx+1] ~= 1)
	and (map[self.mapy-1] and map[self.mapy-1][self.mapx  ] ~= 1)
	and (map[self.mapy+1] and map[self.mapy+1][self.mapx  ] ~= 1) then
		quad = lutro.graphics.newQuad(80, 64, 16, 32, 128, 128)
		lutro.graphics.draw(tileset, quad, self.x, self.y-16)

	-- left end
	elseif  (map[self.mapy  ] and map[self.mapy  ][self.mapx-1] ~= 1)
	and (map[self.mapy-1] and map[self.mapy-1][self.mapx  ] ~= 1)
	and (map[self.mapy+1] and map[self.mapy+1][self.mapx  ] ~= 1) then
		quad = lutro.graphics.newQuad(16, 64, 16, 32, 128, 128)
		lutro.graphics.draw(tileset, quad, self.x, self.y-16)
	-- right end
	elseif (map[self.mapy  ] and map[self.mapy  ][self.mapx+1] ~= 1)
	and    (map[self.mapy-1] and map[self.mapy-1][self.mapx  ] ~= 1)
	and    (map[self.mapy+1] and map[self.mapy+1][self.mapx  ] ~= 1) then
		quad = lutro.graphics.newQuad(48, 64, 16, 32, 128, 128)
		lutro.graphics.draw(tileset, quad, self.x, self.y-16)
	-- top end
	elseif (map[self.mapy-1] and map[self.mapy-1][self.mapx  ] ~= 1)
	and    (map[self.mapy  ] and map[self.mapy  ][self.mapx-1] ~= 1)
	and    (map[self.mapy  ] and map[self.mapy  ][self.mapx+1] ~= 1) then
		quad = lutro.graphics.newQuad(80, 0, 16, 32, 128, 128)
		lutro.graphics.draw(tileset, quad, self.x, self.y-16)
	-- bottom end
	elseif (map[self.mapy+1] and map[self.mapy+1][self.mapx  ] ~= 1)
	and    (map[self.mapy  ] and map[self.mapy  ][self.mapx-1] ~= 1)
	and    (map[self.mapy  ] and map[self.mapy  ][self.mapx+1] ~= 1) then
		quad = lutro.graphics.newQuad(80, 48, 16, 16, 128, 128)
		lutro.graphics.draw(tileset, quad, self.x, self.y)

	-- horizontal bar
	elseif (map[self.mapy+1] and map[self.mapy+1][self.mapx  ] ~= 1)
	and    (map[self.mapy-1] and map[self.mapy-1][self.mapx  ] ~= 1) then
		quad = lutro.graphics.newQuad(32, 64, 16, 32, 128, 128)
		lutro.graphics.draw(tileset, quad, self.x, self.y-16)
	-- vertical bar
	elseif (map[self.mapy  ] and map[self.mapy  ][self.mapx-1] ~= 1)
	and    (map[self.mapy  ] and map[self.mapy  ][self.mapx+1] ~= 1)
	and    (map[self.mapy  ] and map[self.mapy  ][self.mapx-1] ~= nil)
	and    (map[self.mapy  ] and map[self.mapy  ][self.mapx+1] ~= nil) then
		quad = lutro.graphics.newQuad(80, 32, 16, 16, 128, 128)
		lutro.graphics.draw(tileset, quad, self.x, self.y)

	-- top left
	elseif (map[self.mapy] and map[self.mapy][self.mapx-1] ~= 1)
	and (map[self.mapy-1] and map[self.mapy-1][self.mapx] ~= 1) then
		quad = lutro.graphics.newQuad(16, 0, 16, 32, 128, 128)
		lutro.graphics.draw(tileset, quad, self.x, self.y-16)
	-- top right
	elseif (map[self.mapy] and map[self.mapy][self.mapx+1] ~= 1)
	and (map[self.mapy-1] and map[self.mapy-1][self.mapx] ~= 1) then
		quad = lutro.graphics.newQuad(48, 0, 16, 32, 128, 128)
		lutro.graphics.draw(tileset, quad, self.x, self.y-16)
	-- bottom right
	elseif (map[self.mapy] and map[self.mapy][self.mapx+1] ~= 1)
	and (map[self.mapy+1] and map[self.mapy+1][self.mapx] ~= 1) then
		quad = lutro.graphics.newQuad(48, 48, 16, 16, 128, 128)
		lutro.graphics.draw(tileset, quad, self.x, self.y)
	-- bottom left
	elseif (map[self.mapy] and map[self.mapy][self.mapx-1] ~= 1)
	and (map[self.mapy+1] and map[self.mapy+1][self.mapx] ~= 1) then
		quad = lutro.graphics.newQuad(16, 48, 16, 16, 128, 128)
		lutro.graphics.draw(tileset, quad, self.x, self.y)

	-- left
	elseif (map[self.mapy] and map[self.mapy][self.mapx-1] ~= 1)
	and (map[self.mapy] and map[self.mapy][self.mapx-1] ~= nil) then
		quad = lutro.graphics.newQuad(16, 32, 16, 16, 128, 128)
		lutro.graphics.draw(tileset, quad, self.x, self.y)
	-- right
	elseif (map[self.mapy] and map[self.mapy][self.mapx+1] ~= 1)
	and (map[self.mapy] and map[self.mapy][self.mapx+1] ~= nil) then
		quad = lutro.graphics.newQuad(48, 32, 16, 16, 128, 128)
		lutro.graphics.draw(tileset, quad, self.x, self.y)
	-- top
	elseif (map[self.mapy-1] and map[self.mapy-1][self.mapx] ~= 1) then
		quad = lutro.graphics.newQuad(32, 0, 16, 32, 128, 128)
		lutro.graphics.draw(tileset, quad, self.x, self.y-16)
	-- bottom
	elseif (map[self.mapy+1] and map[self.mapy+1][self.mapx] ~= 1) then
		quad = lutro.graphics.newQuad(32, 48, 16, 16, 128, 128)
		lutro.graphics.draw(tileset, quad, self.x, self.y)

	-- center
	else
		quad = lutro.graphics.newQuad(32, 32, 16, 16, 128, 128)
		lutro.graphics.draw(tileset, quad, self.x, self.y)
	end
	
end

