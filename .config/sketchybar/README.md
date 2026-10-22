# SketchyBar

Active config: `~/.config/sketchybar`.
Requires SketchyBar, Lua, SbarLua, and `rift-cli` on PATH.

Reload with `sketchybar --reload`; loaded Lua files also hot-reload on save.
Keep the active config's file symlinks in sync when adding or removing modules.

## Lua upgrades

SbarLua is a compiled Lua module. After a Lua major-version upgrade, rebuild it
before restarting SketchyBar; an incompatible module can crash Lua.

```sh
work=$(mktemp -d)
git clone --depth 1 https://github.com/FelixKratz/SbarLua.git "$work/SbarLua"
cd "$work/SbarLua"
make
cp "$HOME/.local/share/sketchybar_lua/sketchybar.so" \
   "$HOME/.local/share/sketchybar_lua/sketchybar.so.backup"
make install
lua -e 'package.cpath = package.cpath .. ";" .. os.getenv("HOME") .. "/.local/share/sketchybar_lua/?.so"; require("sketchybar")'
sketchybar --reload
```

Check SbarLua's bundled Lua major/minor version matches `lua -v` before building.
If loading fails, do not reload: use a compatible Lua runtime/module pair.
The backup only works with its original Lua version.

## Checks

Tracked mocked checks leave the live bar untouched:

```sh
lua tests/checks.lua
```

## Behavior

- Popups close only when opening another popup, not on pointer exit, app switches,
  actions, or repeated clicks on the same parent. Wi-Fi and battery actions share
  row spacing and subtle hover feedback.
- Normal content stays white; bold emphasizes the calendar heading and today.
  Color is reserved for low-battery warnings and Rift service mode.

- Occupied and active Rift workspaces appear, each in its own pill with app icons.
  Each pill has 8px outer padding; number-to-app gap is 12px, with one space between app icons.
- Workspace changes query workspaces only; binding-mode changes query mode only.
- A 10-second watchdog restores subscriptions after Rift restarts.
- Calendar shows the current month, with a centered bold heading and bold today.
  The clock updates every 30 seconds; the grid rebuilds only when the date changes.
- Battery shows percentage and power-source icon. Red at <=20% on battery;
  normal color on AC. Devices without battery omit the item.
- Wi-Fi shows connection state, not signal strength. SSID and negotiated link
  rate load only when opening its popup. “Link rate” is not an internet speed test.
  Failed queries clear stale details; delayed rate responses cannot undo a disconnect.
- Wi-Fi uses `en0`, matching this machine; change interface on other hardware.
