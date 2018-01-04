#!/usr/bin/bash
cd /home/fu-fu/scripts
if [ -z $1 ] ; then
#	sh urxvt.sh #-e 
	fbrun -text "./man.sh "	

else
ARG=$@
#	sh urxvt.sh
#if [ -a /tmp/misc/mannumtitle ] ; then
#	A=$(cat /tmp/misc/mannumtitle)
#	let A++;
#	echo $A > /tmp/misc/mannumtitle
#else
#	mkdir /tmp/misc/
#	echo 0 > /tmp/misc/mannumtitle
#	A=0
#fi
A=$1
sh urxvt.sh -T "man-$A" -e man -Hlynx $ARG
fi
