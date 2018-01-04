#!/bin/bash

echo "ARG1 <int> Number of torrents to do/try."
echo "ARG2 <str> URL for kind of music from TPB."


IFS="$(printf '\n\t')" #Sets file's to not be as stupid

DIR="/tmp/musictor" #Directory to do all the stuffs in
mkdir $DIR -p

if [ "$1" == "" ]; then
	NUM=1
else
	NUM=$1
fi

if [ "$2" == "" ]; then
	URL="http://thepiratebay.se/music/genre/ambient"
#	URL="http://thepiratebay.se/music/genre/alternative"
else
	URL=$2
fi

#This is another directory, but can just be cnahged here.
mkdir ~/.cache/wget -p
cd ~/.cache/wget


#DISABLES UPDATING THE LOCAL CACHE OF TORRENTS
touch /tmp/musictor/updated

#UPDATES THE LOCAL CACHE OF TORRENTS
if [ ! -e /tmp/musictor/updated ]; then
#  wget -H -r -l 2 --domains="thepiratebay.org,thepiratebay.se" $URL
  wget -H -r -l 1 --domains="thepiratebay.org,thepiratebay.se" $URL -O onefile.txt
  touch /tmp/musictor/updated
fi
#wget -r -l 1 $URL -q &
#sleep 30

#cd $DIR
#mkdir mnt
#mkdir misc
#cd misc

#if [ -e $DIR/magnets.txt ]; then
#	echo "Magnet file already exsists"
#else
#	for i in `find ./ -type f`; do cat $i | grep magnet | cut -d '"' -f2  ; done > $DIR/magnets.txt
#fi

cat onefile.txt  | grep -a magnet | cut -d '"' -f2 > $DIR/magnets.txt

cd $DIR
mkdir mnt -p
#link=`cat * | grep magnet | awk '{print $2}' | grep magnet | cut -d '"' -f 2 | sort -R | head -n 1`
i=0
while [[ $i -le $NUM ]] ; do
  echo $i
  let i++
  link=`cat magnets.txt | sort -R | head -n 1`
  echo $link >> $DIR/torrent-links.txt
  torrent-mount $link ./mnt & 
done
