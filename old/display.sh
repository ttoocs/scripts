#!/bin/sh
A=$1
if [ "$A" = "1" ]; then
xrandr --output VGA-1 --mode 1600x1200 --above LVDS-1
else [ "$A" = "2" ]
xrandr --output VGA-1 --off
fi
