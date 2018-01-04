#!/bin/bash
X=$1
Y=$2
R=60

if [ "$3" == "" ]; then
	OUT=`xrandr | grep -i virt | grep disconnected | awk '{print $1}'`
else
	OUT=$3
fi

MODE=`cvt $X $Y $R | grep Mode | cut -f 2- -d ' '`
NAME=`echo $MODE | awk '{print $1}'`
echo "Mode:"
echo $MODE
echo "Name"
echo $NAME
echo "OUTPUT"
echo $OUT
echo "NEWMODE"
xrandr --newmode $MODE
echo "ADDMODE"
xrandr --addmode $OUT $NAME
echo "SETMODE"
xrandr --output $OUT --mode $NAME

function fin {
	echo "OFF"
	xrandr --output $OUT --off
	xrandr --delmode $OUT $NAME
}

#while true; do
	read -p "Enter to exit"
#	sleep 1;
#done

trap fin EXIT QUIT TERM

