local colors = require("colors")
local popup = {}
local parents = {}

local function close_all()
	for _, parent in ipairs(parents) do
		parent:set({ popup = { drawing = false } })
	end
end

function popup.attach(parent, refresh)
	table.insert(parents, parent)
	parent:subscribe("mouse.clicked", function()
		local opening = parent:query().popup.drawing == "off"
		close_all()
		if opening then
			refresh()
			parent:set({ popup = { drawing = true } })
		end
	end)
	parent:subscribe("front_app_switched", close_all)
end

function popup.action(item, callback)
	item:set({
		width = 232,
		background = {
			color = colors.transparent,
			border_width = 0,
		},
	})
	item:set({ background = { drawing = true } })
	item:subscribe("mouse.entered", function()
		item:set({ background = { color = colors.hover } })
	end)
	item:subscribe("mouse.exited", function()
		item:set({ background = { color = colors.transparent } })
	end)
	item:subscribe("mouse.clicked", function()
		close_all()
		item:set({ background = { color = colors.transparent } })
		callback()
	end)
end

return popup
