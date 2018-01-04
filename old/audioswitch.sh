#!/bin/bash

FILE=/tmp/audioswitch.toggle
if [ ! -e $FILE ] ; then
	touch $FILE
	pacmd set-sink-port 0 analog-output-headphones
else
	rm $FILE
	pacmd set-sink-port 0 analog-output-speaker
fi
