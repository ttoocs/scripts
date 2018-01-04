#!/bin/bash

sleep 20
for i in {0..1500} ; do
scrot $i.png
xdotool mousemove 90 90
xdotool click 1
sleep 2;
done

