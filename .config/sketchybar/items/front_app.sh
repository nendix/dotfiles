#!/bin/sh

sketchybar --add item front_app left \
           --set front_app \
           icon.font="sketchybar-app-font:Regular:14.0" \
           icon.padding_right=2 \
           icon.drawing=on \
           label.font="$FONT:Regular:14.0" \
           label.padding_left=2 \
           update_freq=2 \
           script="$PLUGIN_DIR/front_app.sh" \
           --subscribe front_app front_app_switched
