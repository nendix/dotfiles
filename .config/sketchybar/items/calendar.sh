#!/bin/sh

sketchybar --add item calendar right \
    --set calendar \
    icon.drawing=off \
    update_freq=1 \
    background.padding_right=0 \
    script="$PLUGIN_DIR/calendar.sh" \
    popup.align=right \
    click_script="$PLUGIN_DIR/popup/calendar.sh & $PLUGIN_DIR/popup/toggle.sh calendar"

# Calendar popup items - one for each line
sketchybar --add item calendar.month popup.calendar \
    --set calendar.month \
    width=156 \
    icon.drawing=off \
    background.drawing=off

sketchybar --add item calendar.week popup.calendar \
    --set calendar.week \
    width=156 \
    icon.drawing=off \
    background.drawing=off

sketchybar --add item calendar.days1 popup.calendar \
    --set calendar.days1 \
    width=156 \
    icon.drawing=off \
    background.drawing=off

sketchybar --add item calendar.days2 popup.calendar \
    --set calendar.days2 \
    icon.drawing=off \
    width=156 \
    background.drawing=off

sketchybar --add item calendar.days3 popup.calendar \
    --set calendar.days3 \
    icon.drawing=off \
    width=156 \
    background.drawing=off

sketchybar --add item calendar.days4 popup.calendar \
    --set calendar.days4 \
    icon.drawing=off \
    width=156 \
    background.drawing=off

sketchybar --add item calendar.days5 popup.calendar \
    --set calendar.days5 \
    icon.drawing=off \
    width=156 \
    background.drawing=off
