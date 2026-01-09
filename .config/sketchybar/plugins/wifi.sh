#!/bin/sh

# Get WiFi interface summary which contains all network info
WIFI_SUMMARY="$(ipconfig getsummary en0 2>/dev/null)"

# Check if WiFi is connected
CONNECTED="$(echo "$WIFI_SUMMARY" | grep "LinkStatusActive" | awk '{print $3}')"

if [ "$CONNECTED" != "TRUE" ]; then
    sketchybar --set "$NAME" icon="󰤭" label="" \
               --set wifi.ssid label.string="Not Connected" \
               --set wifi.speed label.string="--"
    exit 0
fi

# Get detailed WiFi information using system_profiler for signal strength
WIFI_INFO="$(system_profiler SPAirPortDataType 2>/dev/null | grep -A 10 "Current Network Information" | head -15)"

# Extract signal strength (RSSI in dBm)
SIGNAL_RAW="$(echo "$WIFI_INFO" | grep "Signal / Noise" | head -1 | awk -F': ' '{print $2}' | awk '{print $1}')"
SIGNAL_VALUE="${SIGNAL_RAW:--100}"

# Select icon based on signal strength
# Signal ranges: Excellent (>-60), Good (-60 to -70), Fair (-70 to -80), Poor (<-80)
if [ "$SIGNAL_VALUE" -ge -60 ] 2>/dev/null; then
    ICON="󰤨"  # Excellent signal
elif [ "$SIGNAL_VALUE" -ge -70 ] 2>/dev/null; then
    ICON="󰤥"  # Good signal
elif [ "$SIGNAL_VALUE" -ge -80 ] 2>/dev/null; then
    ICON="󰤢"  # Fair signal
else
    ICON="󰤟"  # Poor signal
fi

# Update main WiFi item (icon only, no label for clean look)
sketchybar --set "$NAME" icon="$ICON" label=""
