#!/bin/sh

# Update main calendar display (current date/time only)
sketchybar --set $NAME label="$(date +'%d %b %H:%M')"
