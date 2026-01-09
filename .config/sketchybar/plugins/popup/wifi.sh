#!/bin/sh

WIFI_SUMMARY="$(ipconfig getsummary en0 2>/dev/null)"
CONNECTED="$(echo "$WIFI_SUMMARY" | grep "LinkStatusActive" | awk '{print $3}')"

if [ "$CONNECTED" != "TRUE" ]; then
    sketchybar --set wifi.ssid label.string="Not Connected" \
               --set wifi.speed label.string="--"
    exit 0
fi

# Extract SSID from ipconfig output
SSID="$(echo "$WIFI_SUMMARY" | awk -F ' SSID : ' '/ SSID : / {print $2}')"

# Get detailed WiFi information for speed
WIFI_INFO="$(system_profiler SPAirPortDataType 2>/dev/null | grep -A 10 "Current Network Information" | head -15)"

# Extract transmit rate (speed in Mbps)
SPEED_RAW="$(echo "$WIFI_INFO" | grep "Transmit Rate" | head -1 | awk '{print $3}')"
[ -n "$SPEED_RAW" ] && SPEED="$SPEED_RAW Mbps" || SPEED="--"

sketchybar --set wifi.ssid label.string="$SSID" \
           --set wifi.speed label.string="$SPEED"
