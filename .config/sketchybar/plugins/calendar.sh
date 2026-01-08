#!/bin/sh

# Update main calendar display (current date/time)
sketchybar --set $NAME label="$(date +'%d %b %H:%M')"

CAL=$(cal)

# Split calendar into individual lines
MONTH=$(echo "$CAL" | sed -n '1p')
WEEK=$(echo "$CAL" | sed -n '2p')
LINE1=$(echo "$CAL" | sed -n '3p')
LINE2=$(echo "$CAL" | sed -n '4p')
LINE3=$(echo "$CAL" | sed -n '5p')
LINE4=$(echo "$CAL" | sed -n '6p')
LINE5=$(echo "$CAL" | sed -n '7p')

# Update each popup item
sketchybar --set calendar.month label.string="$MONTH" \
           --set calendar.week label.string="$WEEK" \
           --set calendar.days1 label.string="$LINE1" \
           --set calendar.days2 label.string="$LINE2" \
           --set calendar.days3 label.string="$LINE3" \
           --set calendar.days4 label.string="$LINE4" \
           --set calendar.days5 label.string="$LINE5" \
