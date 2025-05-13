#!/bin/bash

sketchybar --add item media right \
           --set media label.max_chars=20 \
                       icon.padding_left=0 \
                       scroll_texts=on \
                       icon=M             \
                       script="$PLUGIN_DIR/media.sh" \
           --subscribe media media_change
