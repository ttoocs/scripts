#!/bin/bash
cd /sys/class/backlight/intel_backlight/

function setbright (){
    sudo setpci -s 00:02.0 F4.B=$1
}

if [ $1 == "0x" ]; then
    sudo setpci -s 00:02.0 F4.B=$2
    exit
fi


##OLD



touch /tmp/$date
step=500000
if [ -w brightness ] ; then
	:
#	echo "Can write"
else
if [ -a brightness ] ; then
	sudo chmod 777 /sys/class/backlight/intel_backlight/brightness > /dev/null
fi
fi

b=$(cat brightness)

if [ "$1" == "down" ] ; then
	if [ $b -lt $step ] ; then
		let b=0
		break 2
	fi
	let b-=$step
else
	let b+=$step
fi

echo $b > brightness 
