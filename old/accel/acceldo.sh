#!/bin/bash
cd ~/scripts/accel
rm data.txt
touch data.txt
(tail -f data.txt | awk 'BEGIN { FS = "," } {print substr($1,3) "\t" substr($2,2,3) }' > data.for ) &
KILLPID=$!
sh accelget.sh 
OTHERPID=$!

#trap [ [ 'kill $KILLPID $OTHERPID' ] 15 ]
