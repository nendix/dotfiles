local settings = require("settings")
local colors = require("colors")

local calendar = sbar.add("item", "calendar", {
  position = "right",
  icon = { drawing = false },
  update_freq = 30,
  background = { padding_left = 8, padding_right = 0 },
  popup = { align = "right" },
})

local function popup_item(name, label)
  return sbar.add("item", "calendar." .. name, {
    position = "popup.calendar",
    width = 212,
    icon = { drawing = false },
    label = {
      string = label or "",
      align = "center",
      font = { family = settings.font, style = "Regular", size = 14 },
    },
    background = { drawing = false },
  })
end

local heading = popup_item("month")
heading:set({ align = "center", label = { font = { style = "Bold" }, color = colors.white } })
popup_item("week", " Su  Mo  Tu  We  Th  Fr  Sa ")
local rows = {}
for week = 1, 6 do
  rows[week] = popup_item("days" .. week)
end

local rendered_date
local function render()
  local today = os.date("*t")
  local date = string.format("%04d-%02d-%02d", today.year, today.month, today.day)
  if date == rendered_date then return end
  rendered_date = date
  local year, month = today.year, today.month
  local first = os.date("*t", os.time({ year = year, month = month, day = 1, hour = 12 }))
  local days = os.date("*t", os.time({ year = year, month = month + 1, day = 0, hour = 12 })).day
  heading:set({ label = { string = os.date("%B %Y", os.time(first)) } })
  for week, row in ipairs(rows) do
    local cells = {}
    local today_column
    for column = 1, 7 do
      local day = (week - 1) * 7 + column - first.wday + 1
      local valid = day >= 1 and day <= days
      local is_today = valid and day == today.day
      cells[column] = valid and not is_today and string.format(" %2d ", day) or "    "
      if is_today then today_column = column end
    end
    row:set({
      label = { string = table.concat(cells) },
      icon = {
        drawing = today_column ~= nil,
        string = string.format(" %2d ", today.day),
        color = colors.white,
        font = { family = settings.font, style = "Bold", size = 14 },
        width = 0,
        align = "left",
        -- Iosevka's fixed half-em advance keeps the overlay on its day cell.
        padding_left = 8 + ((today_column or 1) - 1) * 28,
        padding_right = 0,
      },
    })
  end
end

local function update_calendar()
  calendar:set({ label = os.date("%d %b %H:%M") })
  if calendar:query().popup.drawing == "on" then render() end
end
calendar:subscribe({ "routine", "system_woke" }, update_calendar)
update_calendar()
calendar:subscribe("mouse.clicked", function()
  if calendar:query().popup.drawing == "off" then
    render()
    calendar:set({ popup = { drawing = "on" } })
  else
    calendar:set({ popup = { drawing = "off" } })
  end
end)
