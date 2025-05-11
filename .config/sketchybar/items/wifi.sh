#!/bin/bash

sketchybar --add item wifi right \
           update_freq=10  --set wifi script="$CONFIG_DIR/plugins/wifi.sh" \
           label.drawing=off
