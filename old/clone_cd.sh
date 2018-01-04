#!/bin/bash

##START MAKING FUNCTIONS

function cdinfo () {
#GETS CD info and associated variables
	isoinfo -d -i /dev/sr0 > /tmp/iso.info
	bs=$(cat /tmp/iso.info | grep "Logical block size is" | cut -d " " -f 5)
	c=$( cat /tmp/iso.info | grep "Volume size is:" | cut -d " " -f 4)
	id1=$(cat /tmp/iso.info | grep "Volume id:" | cut -d : -f 2)
	id2=${id1:1}
	id=${id2// /_}
	A=`date +%d-%m-%y`
}

function netinfo () {
	ip=192.168.1.101
	p=48325
	##PUT HERE FOR NET-COPY TO ACTUALLY WORK
	ssh 192.168.1.101 -p 443 -l share "busybox nc -l -p $p > /shared/Shared/cd-rips/$name" &
	sleep 2;
}

function pcdinfo () {
	echo "bs: $bs"
	echo "count: $c"
	echo "volume id: $id"
	echo "final name: $name"
}

function pnetinfo () {
	echo "ip: $ip"
	echo "port: $p"
}

function fancysetup () {
	mkdir /tmp/misc/clone_cd -p 2>/dev/null 1>/dev/null
	cd /tmp/misc/clone_cd
	mknod cd.in p 2>/dev/null 1>/dev/null	#READ FROM CD -> Foo.copy
	mknod cd.out p 2>/dev/null 1>/dev/null	#foo.copy -> image
}

function buffhackset () {
	mkdir /tmp/misc/clone_cd/bufferhack
	cd /tmp/misc/clone_cd/bufferhack
	for i in {0..100}; do
	mknod $i p > /dev/null 2>/dev/null
	done
	mknod end p > /dev/null 2>dev/null
	BBS=100M
}

function bufferhack () {
	bufferhackset
	for i in {0..10}; do
		dd if=./$i of=./$((i+1)) ibs=$BBS obs=$BBS iflag=fullblock status=none conv=noerror &
	done
	dd if=./$((i+1)) ibs=$BBS obs=$bs of=../cd.out status=none conv=noerror &
	cd /tmp/misc/clone_cd
}	

function copy () {
	cd /tmp/misc/clone_cd	##Just in case we arn't put where we want to be
	dd if=/dev/sr0 bs=$bs count=$c conv=noerror status=none of=./cd.in	&	#READ THE DISK IN
	dd if=./cd.in of=./cd.out bs=$bs count=$c conv=noerror status=none &
	dd if=./cd.out bs=$bs count=$c conv=noerror |\
	xz -z -c -6 | \
	##FOR NETWORK
	ncat $ip $p
	##FOR LOCALHOST
	#> /shared/Shared/cd-rips/$name
	
}
function imagemd5 () {
	#FOR NETOWRK
        MI1=$(ssh $ip -p 443 -l share "dd conv=noerror bs=$bs if=/shared/Shared/cd-rips/$name | xz -d | md5sum")
        MI=$(echo $MI1 | cut -d " " -f 1)
	#FOR LOCAL
#	MI=$(dd if=/shared/Shared/cd-rips/$name bs=$bs count=$c | xz -d | md5sum | cut -d " " -f 1)

}

function readiable () {
	if [ -r /dev/sr0 ] ; then
	#	ls -lh /dev/sr0
		echo "CD device is readable"
	else
		ls -lh /dev/sr0
	#	ssh localhost -p 443 -l fu-fu "sudo chmod 664 /dev/sr0"
	fi
}

function additionalinfo () {
	if [ -z $info ] ; then
	        name=$id.$A.iso.xz
	else
        	name=${info// /_}.$id.$A.iso.xz
	fi
}

function checkname () {
	if [ "$A1" != "1" ] ; then
		echo "Is this alright?"
	
		#Verify the thing has enough info with human
		read -e al
		if [ "$al" == "y" ]; then
		        echo "starting the clone"
		else
		       echo "Enter addition info"
		        read -e info
		        name=${info// /_}.$id.$A.iso.xz
	        	echo "Final name is: $name"
		fi
	fi
}
function diskmd5 () {
	MD=$(dd if=/dev/sr0 conv=noerror status=none bs=$bs count=$c | \
	md5sum | cut -d " " -f 1 )
}
#######################################ACTUAL START########################################
A1=$1
if [ "$1" == "1" ] ; then
	info=$2
	
else
	echo "add addition info if wanted, otherwise hit enter for ready"
	read -e info
fi

#CHECK IF READABLE
#readable
#GET CD INFO
cdinfo
additionalinfo $1 $2
pcdinfo
#CHECK NAME WITH HUMAN
checkname
#SETUP NETWORK/print network
netinfo
pnetinfo
#CD CLONING FUNCTIONS
fancysetup
#fanceysetup
#bufferhack
copy
diskmd5
imagemd5

##COMPAIR AND RERUN.

echo "DISK MD5: $MD"
echo "IMAGE MD5: $MI"
if [[ "$MD" = "$MI" ]] ; then
	echo "ALL GOOD"
else
	echo "ERROR OCCURED, retrying."
	sh ~/scripts/clone_cd.sh 1 $info
fi

echo "MANUALLY CHECK MD5SUMS"
echo "DONE"

sleep 5;

eject 

