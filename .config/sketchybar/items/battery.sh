#!/bin/sh

# Main Battery item
sketchybar --add item battery right \
    --set battery \
    script="$PLUGIN_DIR/battery.sh" \
    icon.padding_right=2 \
    label.padding_left=2 \
    label.padding_right=4 \
    background.drawing=off \
    click_script="sketchybar --set battery popup.blur_radius=0 popup.drawing=toggle; sketchybar --animate sin 16 --set battery popup.blur_radius=33" \
    update_freq=60 \

# Popup item for Time Remaining until 0%
sketchybar --add item battery.time popup.battery \
    --set battery.time \
    icon="󱎫" \
    icon.padding_right=2 \
    label.string="Calculating..." \
    label.padding_left=2 \
    background.drawing=off

# Popup item for Battery Settings button
sketchybar --add item battery.settings popup.battery \
    --set battery.settings \
    icon="󰒓" \
    icon.padding_right=2 \
    label.string="Battery Settings" \
    label.padding_left=2 \
    background.drawing=off \
    click_script="open 'x-apple.systempreferences:com.apple.preference.battery'; sketchybar --set battery popup.drawing=toggle"
