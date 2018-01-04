#!/bin/sh
xrandr --output LVDS1 --off
sleep 1;
xrandr --output VGA1 --mode 1600x1200 --above LVDS1
sleep 1;
xrandr --output LVDS1 --mode 1440x900 --below VGA1 --primary 
