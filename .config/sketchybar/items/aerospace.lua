local colors = require("colors")

-- Add custom events
sbar.add("event", "aerospace_workspace_change")
sbar.add("event", "aerospace_monitor_change")
sbar.add("event", "aerospace_mode_change")

-- Create space items dynamically
sbar.exec("aerospace list-workspaces --all", function(result)
  local space_names = {}

  for sid in result:gmatch("%S+") do
    table.insert(space_names, "space." .. sid)

    local space = sbar.add("item", "space." .. sid, {
      position = "left",
      icon = {
        string = sid,
        color = 0x6fe0e0e0,
      },
      label = { drawing = false },
      background = {
        drawing = false,
        padding_right = 0,
        padding_left = 0,
      },
    })

    space:subscribe("aerospace_workspace_change", function(env)
      sbar.exec("aerospace list-workspaces --focused", function(focused)
        focused = focused:gsub("%s+", "")
        if sid == focused then
          sbar.animate("sin", 12, function()
            space:set({
              icon = { highlight = true, highlight_color = colors.white },
              y_offset = 1,
            })
          end)
        else
          sbar.animate("sin", 12, function()
            space:set({
              icon = { highlight = false },
              y_offset = 0,
            })
          end)
        end
      end)
    end)

    space:subscribe("mouse.clicked", function()
      sbar.exec("aerospace workspace " .. sid)
    end)
  end

  -- Bracket for all spaces (created after spaces exist)
  local spaces_bracket = sbar.add("bracket", "spaces", space_names, {
    background = { drawing = true },
  })

  spaces_bracket:subscribe("aerospace_mode_change", function(env)
    local mode = env.MODE or ""
    if mode == "service" then
      sbar.animate("sin", 12, function()
        spaces_bracket:set({ background = { border_color = colors.red } })
      end)
    else
      sbar.animate("sin", 12, function()
        spaces_bracket:set({ background = { border_color = colors.border } })
      end)
    end
  end)

  -- Load front_app after spaces are created so it appears to the right of spaces
  require("items.front_app")
end)
