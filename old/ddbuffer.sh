#!/usr/bin/bash
mkdir /tmp/ddbuffer
cd /tmp/ddbuffer

bs="1024 2048 4K 8K 16K 32K 64K 128K 256K 512K 1024K 2M 4M 8M 16M 32M 64M 128M 256M 512M 1G 2G 3G 4G"
count=""
args=" conv=noerror iflag=fullblock status=none "
if [ $1 -ge 0 ] ; then
	num=$1
else
	num=24
fi

N=$(eval echo {0..$num})
for i in $N  ; do #MAKE THE NODES
mknod $i p 2>/dev/null 1>/dev/null #AND KEEP IT SHUT UP.
#let i++
done
mknod in p 2>/dev/null 1>/dev/null
mknod out p 2>/dev/null 1>/dev/null

#MAKE THE DD.s
(
i=0
for s in $bs ; do 	
dd if=./in of=./$i bs=$s count=1 $args
let i++
done
) &

#while [ $b -le $num ] ; do #MAKE THE READ DD's
#dd if=./$b of=./out bs=8k $args 
#let i++
#done
cat $N > ./out

