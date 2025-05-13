#!/bin/sh

PERCENTAGE="$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)"
CHARGING="$(pmset -g batt | grep 'AC Power')"

if [ "$PERCENTAGE" = "" ]; then
  exit 0
fi

case "${PERCENTAGE}" in
  9[5-9]|100) ICON="󰁹";;
  8[5-9]|9[0-4]) ICON="󰂂";;
  7[5-9]|8[0-4]) ICON="󰂁";;
  6[5-9]|7[0-4]) ICON="󰂀";;
  5[5-9]|6[0-4]) ICON="󰁿";;
  4[5-9]|5[0-4]) ICON="󰁾";;
  3[5-9]|4[0-4]) ICON="󰁽";;
  2[5-9]|3[0-4]) ICON="󰁼";;
  1[5-9]|2[0-4]) ICON="󰁻";;
  1[0-4]) ICON="󰁺";;
  *) ICON="󰂎"
esac

if [[ "$CHARGING" != "" ]]; then
  ICON="󰂄"
fi

# The item invoking this script (name $NAME) will get its icon and label
# updated with the current battery status
sketchybar --set "$NAME" icon="$ICON" label="${PERCENTAGE}%"
