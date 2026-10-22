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
  -- The global subscription preserves the transition from the parent into its popup.
  parent:subscribe({ "mouse.exited", "mouse.exited.global", "front_app_switched" }, close_all)
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
    close_all()
    item:set({ background = { drawing = false } })
    callback()
  end)
end

return popup
