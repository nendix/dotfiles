#!/bin/sh

ITEM="$1"  # calendar, wifi, or battery

# Query current popup state
POPUP_STATE=$(sketchybar --query $ITEM | grep -A1 '"popup":' | grep '"drawing":' | grep -o '"on"\|"off"' | tr -d '"')

if [ "$POPUP_STATE" = "off" ]; then
    # OPEN: Set initial state (shifted up, transparent, no blur)
    sketchybar --set $ITEM popup.y_offset=-10 popup.background.color=0x001a1a1a popup.blur_radius=0 popup.drawing=on
    # Animate to final state (grow down + fade in + blur)
    sketchybar --animate sin 16 --set $ITEM popup.y_offset=0 popup.background.color=0x991a1a1a popup.blur_radius=33
else
    # CLOSE: Hide popup immediately
    sketchybar --set $ITEM popup.drawing=off
fi
