#!/bin/bash

if [ "$1" = "" ]; then
  echo "Making a D10 roll (specify dXXX as first arg)"
  DICE=10
else
  DICE=$1
fi

if [ "$2" = "" ]; then
#  echo "Rolling once (Sepecify in second arg)"
  ROLLS=1
else
  ROLLS=$2
fi

if [ "$3" = "" ]; then
# echo "Offsetting each roll by 1: (Specify in 3rd arg)"
  OFFSET=1
else
  OFFSET=$(($3 + 1))
fi

roll(){
echo $((RANDOM % $1 + $2 ))
}

SUM=0

while [ $ROLLS -gt 0 ]; do
  ROLLS=$(($ROLLS - 1 ))
  A=`roll $DICE $OFFSET`
  LIST=$LIST""$A,
  SUM=$(($A + $SUM))
done
echo "SEQUENCE: "$LIST
echo "SUM: "$SUM
