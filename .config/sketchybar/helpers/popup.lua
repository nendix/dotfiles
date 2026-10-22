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
    if parent:query().popup.drawing == "on" then return end
    close_all()
    refresh()
    parent:set({ popup = { drawing = true } })
  end)
end

function popup.action(item, callback)
  item:set({
    width = 224,
    background = {
      color = colors.hover,
      border_width = 0,
      height = 22,
      padding_left = 4,
      padding_right = 4,
      corner_radius = 5,
    },
  })
  -- Setting a background color enables drawing in SketchyBar.
  item:set({ background = { drawing = false } })
  item:subscribe("mouse.entered", function()
    item:set({ background = { drawing = true } })
  end)
  item:subscribe("mouse.exited", function()
    item:set({ background = { drawing = false } })
  end)
  item:subscribe("mouse.clicked", function()
    item:set({ background = { drawing = false } })
    callback()
  end)
end

return popup
