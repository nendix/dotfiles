#!/bin/bash

sketchybar --add item wifi right \
           update_freq=10  --set wifi script="$CONFIG_DIR/plugins/wifi.sh" \
           --subscribe wifi wifi_change \
           --subscribe wifi system_woke \
