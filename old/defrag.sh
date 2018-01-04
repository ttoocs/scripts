#!/bin/bash
#FIND FILES

SAVEIFS=$IFS
IFS=$(echo -en "\n\b")

#for i in `find /home -xdev -type f `; do filefrag $i ; done  > ~/files


#DEFRAG THEM (BIG FRAGS TO SMALL)
for i in `cat ~/files | sort -rnk2`; do (a=`echo $i | awk '{print substr($1, 0, length($1)-1)}'`; echo $a ; sudo btrfs files defrag  $a ; filefrag $a; echo $i | awk '{print $2}'  ) & done

echo "############################ 1st defrag done #################"


#DEFRAG AGAIN, BUT THE OTHER WAY (SMALL FRAGS TO BIG)
for i in `cat ~/files | sort -nk2`; do a=`echo $i | awk '{print substr($1, 0, length($1)-1)}'`; echo $a ; sudo btrfs files defrag $a ; filefrag $a; echo $i | awk '{print $2}'  ; done

#AND AGAIN. TILL IT IS FAST.

#for i in `cat /home/files | sort -nk2`; do 
