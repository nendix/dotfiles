#!/bin/sh

source "$CONFIG_DIR/plugins/icon_map_fn.sh"

if [ -n "$INFO" ]; then
    icon_map "$INFO"
    
    sketchybar --animate s 16 --set $NAME \
        icon="$icon_result" \
        label="$INFO" 
fi
