#!/bin/bash

WIFI_STATUS=$(networksetup -getairportpower en0 | awk '{print $4}')

if [[ "$WIFI_STATUS" == "On" ]]; then
  RSSI=$(system_profiler SPAirPortDataType -json 2>/dev/null | \
    jq -r '.SPAirPortDataType[0].spairport_airport_interfaces[] | 
           select(._name == "en0").spairport_current_network_information.spairport_signal_noise' | \
    awk '{print $1}')

  if [[ -n "$RSSI" ]]; then
    if [[ "$RSSI" -ge -30 ]]; then
      ICON="󰤨"  # Amazing (≥ -30dBm)
    elif [[ "$RSSI" -ge -67 ]]; then
      ICON="󰤥"  # Very Good (-30 to -67dBm)
    elif [[ "$RSSI" -ge -70 ]]; then
      ICON="󰤢"  # Okay (-67 to -70dBm)
    elif [[ "$RSSI" -ge -80 ]]; then
      ICON="󰤟"  # Not Good (-70 to -80dBm)
    else
      ICON="󰤯"  # Unusable (< -80dBm)
    fi
  else
    ICON="󰤫"  # Disconnected
  fi
else
  ICON="󰤮"  # Wi-Fi Off
fi

sketchybar --set wifi \
  icon="$ICON" \
  label.drawing=off
