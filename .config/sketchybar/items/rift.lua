local colors = require("colors")

sbar.add("event", "rift_workspace_changed")
sbar.add("event", "rift_windows_changed")
sbar.add("event", "rift_binding_mode_changed")

local spaces = {}
local spaces_bracket
local front_app_loaded = false
local border_color = colors.border
local watcher = sbar.add("item", "rift.watcher", {
  drawing = false,
  updates = true,
  update_freq = 10,
})

local function update_mode()
  sbar.exec("rift-cli query binding-mode", function(mode, code)
    if code ~= 0 or type(mode) ~= "string" then return end
    mode = mode:match('^%s*"(.-)"%s*$')
    if not mode then return end
    border_color = mode == "service" and colors.red or colors.border
    if spaces_bracket then
      spaces_bracket:set({ background = { border_color = border_color } })
    end
  end)
end

local function refresh()
  sbar.exec("rift-cli query workspaces", function(workspaces, exit_code)
    if exit_code ~= 0 or type(workspaces) ~= "table" then return end

    local seen = {}
    local changed = false
    local has_windows = false
    local first_visible, last_visible
    for _, workspace in ipairs(workspaces) do
      if workspace.window_count > 0 then
        first_visible = first_visible or workspace.index
        last_visible = workspace.index
      end
    end
    for _, workspace in ipairs(workspaces) do
      local index = workspace.index
      seen[index] = true
      if not spaces[index] then
        local space = sbar.add("item", "space." .. index, {
          position = "left",
          icon = {
            string = workspace.name,
            color = 0x6fe0e0e0,
            padding_left = 4,
            padding_right = 4,
          },
          label = { drawing = false },
          background = { drawing = false, padding_right = 0, padding_left = 0 },
        })
        space:subscribe("mouse.clicked", function()
          sbar.exec("rift-cli execute workspace switch " .. index)
        end)
        spaces[index] = space
        changed = true
      end
      local occupied = workspace.window_count > 0
      has_windows = has_windows or occupied
      spaces[index]:set({
        drawing = occupied,
        icon = {
          string = workspace.name,
          highlight = workspace.is_active,
          highlight_color = colors.white,
          padding_left = index == first_visible and 8 or 4,
          padding_right = index == last_visible and 8 or 4,
        },
      })
    end

    for index, space in pairs(spaces) do
      if not seen[index] then
        sbar.remove(space.name)
        spaces[index] = nil
        changed = true
      end
    end

    if changed then
      if spaces_bracket then sbar.remove("spaces") end
      local names = {}
      for _, workspace in ipairs(workspaces) do
        table.insert(names, "space." .. workspace.index)
      end
      spaces_bracket = #names > 0 and sbar.add("bracket", "spaces", names, {
        background = { drawing = true, border_color = border_color },
      }) or nil
    end

    if spaces_bracket then
      spaces_bracket:set({ drawing = has_windows })
    end

    if not front_app_loaded then
      require("items.front_app")
      front_app_loaded = true
    end

    if changed then
      local names = {}
      for _, workspace in ipairs(workspaces) do
        table.insert(names, "space." .. workspace.index)
      end
      table.insert(names, "front_app")
      sbar.exec("sketchybar --reorder " .. table.concat(names, " "))
    end
  end)
end

local function reconnect()
  -- Rift deduplicates subscriptions; watchdog recovers after WM restarts.
  for _, event in ipairs({ "workspace_changed", "windows_changed", "binding_mode_changed" }) do
    sbar.exec("rift-cli subscribe cli --event " .. event
      .. " --command /opt/homebrew/bin/sketchybar --args --trigger --args rift_" .. event)
  end
  update_mode()
  refresh()
end

watcher:subscribe({ "routine", "system_woke" }, reconnect)
watcher:subscribe({ "rift_workspace_changed", "rift_windows_changed" }, refresh)
watcher:subscribe("rift_binding_mode_changed", update_mode)
reconnect()
