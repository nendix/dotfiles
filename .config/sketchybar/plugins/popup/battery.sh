#!/bin/sh

BATT_INFO="$(pmset -g batt)"
CHARGING="$(echo "$BATT_INFO" | grep 'AC Power')"

if [ -z "$CHARGING" ]; then
    # Only show time remaining when discharging (on battery)
    TIME_REMAINING="$(echo "$BATT_INFO" | grep -o '[0-9]\+:[0-9]\+ remaining')"
    [ -z "$TIME_REMAINING" ] && TIME_REMAINING="--"
else
    # When charging or plugged in
    TIME_REMAINING="Plugged in"
fi

sketchybar --set battery.time label.string="$TIME_REMAINING"
