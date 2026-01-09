#!/bin/sh

# Get battery information
BATT_INFO="$(pmset -g batt)"
PERCENTAGE="$(echo "$BATT_INFO" | grep -Eo "\d+%" | cut -d% -f1)"
CHARGING="$(echo "$BATT_INFO" | grep 'AC Power')"

# Exit if no battery data
if [ "$PERCENTAGE" = "" ]; then
  exit 0
fi

# Calculate icon index based on percentage (0-10)
INDEX=$((PERCENTAGE / 10))

# Select appropriate icon based on charging state and percentage
if [[ "$CHARGING" != "" ]]; then
    # Charging icons (0-10%, 10-20%, ..., 90-100%)
    case $INDEX in
        0) ICON="󰢟" ;;   # 0-10% charging
        1) ICON="󰢜" ;;   # 10-20% charging
        2) ICON="󰂆" ;;   # 20-30% charging
        3) ICON="󰂇" ;;   # 30-40% charging
        4) ICON="󰂈" ;;   # 40-50% charging
        5) ICON="󰢝" ;;   # 50-60% charging
        6) ICON="󰂉" ;;   # 60-70% charging
        7) ICON="󰢞" ;;   # 70-80% charging
        8) ICON="󰂊" ;;   # 80-90% charging
        9) ICON="󰂋" ;;   # 90-100% charging
        10) ICON="󰂅" ;;  # 100% (full) charging
        *) ICON="󰂅" ;;   # Fallback
    esac
else
    # Discharging icons (0-10%, 10-20%, ..., 90-100%)
    case $INDEX in
        0) ICON="󰂎" ;;   # 0-10% (critical)
        1) ICON="󰁺" ;;   # 10-20%
        2) ICON="󰁻" ;;   # 20-30%
        3) ICON="󰁼" ;;   # 30-40%
        4) ICON="󰁽" ;;   # 40-50%
        5) ICON="󰁾" ;;   # 50-60%
        6) ICON="󰁿" ;;   # 60-70%
        7) ICON="󰂀" ;;   # 70-80%
        8) ICON="󰂁" ;;   # 80-90%
        9) ICON="󰂂" ;;   # 90-100%
        10) ICON="󰁹" ;;  # 100% (full)
        *) ICON="󰁹" ;;   # Fallback
    esac
fi

# Update main battery item (icon and percentage)
sketchybar --set "$NAME" icon="$ICON" label="${PERCENTAGE}%"
