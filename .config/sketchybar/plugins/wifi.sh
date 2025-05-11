#!/bin/bash

WIFI_SSID=$(networksetup -getairportnetwork en0 | awk '{print $4}')

if [[ -n "$WIFI_SSID" ]]; then
  ICON="󰖩"  # Connected
else
  ICON="󰖪"  # Disconnected
fi

sketchybar --set wifi \
  icon="$ICON" \
