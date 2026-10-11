# SketchyBar

Active config: `~/.config/sketchybar`. Menus variant: `../sketchybar.menus`.
Both require SketchyBar, Lua, SbarLua, and `rift-cli` on PATH.

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

## Menus variant

Source is versioned; compiled helper is ignored. Build after checkout:

```sh
cd ../sketchybar.menus/helpers/menus
make
```

Helper needs Accessibility permission and uses macOS private frameworks; rebuild
and check it after macOS upgrades. Run only one config at a time: both target the
default SketchyBar instance. Set `CONFIG_DIR` to the chosen config directory when
launching the menus variant so it finds its helper.

## Checks

Local, Git-ignored mocked checks leave the live bar untouched:

```sh
lua tests/checks.lua
lua tests/checks.lua ../sketchybar.menus
```

## Behavior

- Only occupied Rift workspaces appear; 4px inner / 8px outer workspace padding.
- Workspace changes query workspaces only; binding-mode changes query mode only.
- A 10-second watchdog restores subscriptions after Rift restarts.
- Battery shows percentage and power-source icon. Red at <=20% on battery;
  normal color on AC. Devices without battery omit the item.
- Wi-Fi shows connection state, not signal strength. SSID and negotiated link
  rate load only when opening its popup; Mbps is not an internet speed test.
- Wi-Fi uses `en0`, matching this machine; change interface on other hardware.
