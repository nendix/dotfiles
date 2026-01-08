#!/bin/sh

sketchybar --add event aerospace_workspace_change
sketchybar --add event aerospace_monitor_change
sketchybar --add event aerospace_mode_change

for sid in $(aerospace list-workspaces --all); do
    sketchybar --add item space.$sid left \
        --subscribe space.$sid aerospace_workspace_change \
        --set space.$sid \
        icon="$sid" \
        icon.color=0x6fe0e0e0 \
        label.drawing=off \
        background.drawing=off \
        background.padding_right=0 \
        background.padding_left=0 \
        update_freq=2 \
        click_script="aerospace workspace $sid" \
        script="$CONFIG_DIR/plugins/aerospace.sh $sid"
done

sketchybar --add bracket spaces '/space\..*/' \
           --subscribe spaces aerospace_mode_change \
           --set spaces \
                background.drawing=on \
                script="$CONFIG_DIR/plugins/aerospace.sh" \
