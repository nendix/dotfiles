#!/bin/bash

sketchybar --add item wifi right \
           --set wifi script="$CONFIG_DIR/plugins/wifi.sh" \
                      update_freq=10 \
