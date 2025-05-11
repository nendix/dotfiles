#!/bin/bash

sketchybar --add item chevron left \
           --set chevron icon= label.drawing=off background.drawing=off icon.padding_right=0 icon.padding_left=0  \
           --add item front_app left \
           --set front_app icon.drawing=off script="$PLUGIN_DIR/front_app.sh" \
           --subscribe front_app front_app_switched
