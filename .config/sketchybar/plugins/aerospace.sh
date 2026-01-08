#!/bin/sh

source "$CONFIG_DIR/colors.sh"

# Handle mode changes (when called for the bracket item "spaces")
if [ "$NAME" = "spaces" ] && [ -n "$MODE" ]; then
    if [ "$MODE" = "service" ]; then
        sketchybar --animate sin 12 --set spaces \
            background.border_color=$RED
    else
        sketchybar --animate sin 12 --set spaces \
            background.border_color=$BORDER
    fi
    exit 0
fi

# Handle workspace changes (when called for individual space items)
FOCUSED_WORKSPACE=$(aerospace list-workspaces --focused)

if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
    sketchybar --animate sin 12 --set $NAME \
        icon.highlight_color=$WHITE \
        icon.highlight=on \
        y_offset=1
else
    sketchybar --animate sin 12 --set $NAME \
        icon.highlight=off \
        y_offset=0
fi
