#!/bin/bash
cd /tmp
mkdir phonething
cd phonething
adb wait-for-device
(while true; do
 adb shell screencap -p | sed 's/\r$//' > screen.new.png ; \
 mv screen.new.png screen.png ; \
 sleep 0.1; \
 done ) &
sleep 1;
feh screen.png -g 300x530 --scale-down -R 1 &
sleep 1;

echo "Put mouse over the window and press enter"
read 
eval $(xdotool getmouselocation --shell) #Gets the WINDOW
feh=$WINDOW
echo "WINDOW ID: "$feh

#geo=`xdotool getwindowgeometry $feh`

##NOTE FOR CLICKING:
#Y:Offset is 20 (Goes up/down)
#X:Offset is 0
#Need to calculate scale from the new sizes
#Need to capture presses
#Need to capture swipes




