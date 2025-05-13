#!/bin/bash

WIFI_STATUS=$(networksetup -getairportpower en0 | awk '{print $4}')

if [[ "$WIFI_STATUS" == "On" ]]; then
  ICON="󰖩"  # Connected
else
  ICON="󰖪"  # Disconnected
fi

sketchybar --set wifi \
  icon="$ICON" \
  label.drawing=off
