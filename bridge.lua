local bridge = {}
bridge.__index = bridge

function newBridge(object)
	local n = object
	n.type = "bridge"
	n.width = 16
	n.height = 1
	n.img = lutro.graphics.newImage("assets/bridge.png")

	return setmetatable(n, bridge)
end

function bridge:draw()
	lutro.graphics.draw(self.img, self.x, self.y)
end
