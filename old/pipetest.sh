#!/usr/bin/bash
mkdir /tmp/pipetest
cd /tmp/pipetest
bs=1G
num=50
for i in {0..50}; do
mknod $i p
done

#dd if=/dev/zero of=./0 bs=$bs & pid=$!
for i in {0..49}; do
dd if=./$i of=./$((i+1)) bs=$bs iflag=fullblock & lpid=$!
done

echo "All the dd's are set, check /tmp/pipetest/$i"
echo "PID of first dd is $pid"
echo "PID of last dd is $lpid"
#echo $i

