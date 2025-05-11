#!/bin/bash

WIFI_STATUS=$(networksetup -getairportpower en0 | awk '{print $4}')
WIFI_SSID=$(networksetup -getairportnetwork en0 | awk '{print $4}')

if [[ "$WIFI_STATUS" == "On" && -n "$WIFI_SSID" ]]; then
  ICON="󰖩"  # Connected
else
  ICON="󰖪"  # Disconnected
fi

sketchybar --set wifi \
  icon="$ICON" \
