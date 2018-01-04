#!/bin/sh
for i in {0..24421}; do
#b=$(($i*4096000))
b=$(($i*4000))
#echo $b
#echo ${b}K
sudo dd if=/dev/sda bs=4096000 skip=${b}K > /dev/fb0

done

##BASH NO LIKEY
#for i in {0..100030242816..4096000}; do
#do dd if=/dev/sda bs=4000 count=1024 skip $i > /dev/fb0
#echo $i
#sleep 1 
#done
