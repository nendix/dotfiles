#!/bin/sh

# Main WiFi item
sketchybar --add item wifi right \
    --set wifi \
    script="$PLUGIN_DIR/wifi.sh" \
    update_freq=60 \
    click_script="sketchybar --set wifi popup.drawing=toggle popup.blur_radius=0; sketchybar --animate sin 16 --set wifi popup.blur_radius=33 " \
    background.drawing=off \
    icon.padding_left=4 \
    label.drawing=off \

# Popup item for SSID
sketchybar --add item wifi.ssid popup.wifi \
    --set wifi.ssid \
    icon="󰀂" \
    icon.padding_right=2 \
    label.string="Not Connected" \
    label.padding_left=2 \
    background.drawing=off

# Popup item for Connection Speed
sketchybar --add item wifi.speed popup.wifi \
    --set wifi.speed \
    icon="󰓅" \
    icon.padding_right=2 \
    label.string="-- Mbps" \
    label.padding_left=2 \
    background.drawing=off

# Popup item for Network Settings button
sketchybar --add item wifi.settings popup.wifi \
    --set wifi.settings \
    icon="󰒓" \
    icon.padding_right=2 \
    label.string="Wi-Fi Settings" \
    label.width=120 \
    label.padding_left=2 \
    background.drawing=off \
    click_script="open 'x-apple.systempreferences:com.apple.wifi-settings'; sketchybar --set wifi popup.drawing=toggle"
