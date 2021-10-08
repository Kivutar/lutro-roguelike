local bridge = {}
bridge.__index = bridge

function newBridge(object)
	local n = object
	n.type = "bridge"
	n.width = 16
	n.height = 1

	return setmetatable(n, bridge)
end

function bridge:draw()
	lutro.graphics.draw(IMG_bridge, self.x, self.y)
end
