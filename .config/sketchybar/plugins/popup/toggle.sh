#!/bin/sh

ITEM="$1"  # calendar, wifi, or battery

# Query current popup state
POPUP_STATE=$(sketchybar --query $ITEM | grep -A1 '"popup":' | grep '"drawing":' | grep -o '"on"\|"off"' | tr -d '"')

if [ "$POPUP_STATE" = "off" ]; then
    # OPEN: Show popup with no blur, then animate blur in
    sketchybar --set $ITEM popup.blur_radius=0 popup.drawing=on
    sketchybar --animate sin 16 --set $ITEM popup.blur_radius=33
else
    # CLOSE: Hide popup instantly
    sketchybar --set $ITEM popup.drawing=off
fi
