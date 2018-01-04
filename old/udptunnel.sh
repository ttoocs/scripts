#!/bin/bash

##BROKEN
#exit


ip=$1
port=$2
args="-C -p 443"
file="/tmp/udptun$port"
forward="-L $port:localhost:$port"

function clean {
    kill $ncssh
    kill $ncssh2
    kill $ncloc
    rm $file
    ssh $ip $args "kill `lsof $file | awk '{print $2}'`"
    ssh $ip $args "rm $file"
}

trap clean EXIT INT TSTP 

mkfifo $file
ssh $ip $args "mkfifo $file"  #WORKS
ssh $ip $args "nc -l -p $port < $file | nc -u localhost $port > $file" &
ncssh=$!
ssh $ip $args $forward &
ncssh2=$!
sleep 1;
( nc -l -u -p $port < $file | nc localhost $port > $file ) &
ncloc=$!

wait;
kill $ncssh
kill $ncssh2
kill $ncloc

rm $file
ssh $ip $args "rm $file"

exit

mkfifo $file
echo "Local porting"
(nc -l -u -p $port < $file | nc localhost $port > /tmp/fifo )&
ssh $ip $args -L $port:localhost:$port  "mkfifo $file"
echo "Remote porting, (Will hold)"
ssh $ip $args -L $port:localhost:$port  "nc -l -p $port < $file | nc -u localhost $port > $file" 
echo "Closed, cleaning up."
ssh $ip $args  "rm $file"
rm $file

