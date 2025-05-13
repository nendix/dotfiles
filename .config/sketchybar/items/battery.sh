#!/bin/bash

sketchybar --add item battery right \
           --set battery icon.padding_right=3 label.padding_left=3 \
           update_freq=120 script="$PLUGIN_DIR/battery.sh" \
           --subscribe battery system_woke power_source_change
