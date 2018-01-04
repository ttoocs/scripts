#!/bin/bash

function tap () {
    adb shell input tap $1 $2
}
function swipe () {
    #x1 y1 x2 y2
    adb shell input swipe $1 $2 $3 $4
}
function nextpage {
#    toemoji ##For mass send mode

    y_off=800
    x_off=350

    x_end=50
    y_end=800
    swipe $x_off $y_off $x_end $y_end

#    toemoji ##For mass send mode.
}
function toemoji {
    tap 650 1140 #Switches to emoji
}
function tapemoji {
    #Takes two values $1 = 0-6 , $2 = 0-2
    x_off=50 #The X offset 
    y_off=800 #The Y offset

    x_dif=100 #The diffrence between emojis
    y_dif=100 

#    tap $(($x_off+$x_diff*$1)) $(($y_off+$y_diff*$2))
    x=$(($x_dif*$1))
    y=$(($y_dif*$2))
    tap $(($x_off+$x)) $(($y_off+$y))
}
function send() {
    tap 650 610
}

##Actual spamy bit.
for page in {0..41}; do #43 pages of emojis
    toemoji #Page send mode
    for col in {0..2}; do
        for row in {0..6}; do
#            toemoji #Mass send mode
            tapemoji $row $col
#            send   #Mass send mode
        done
    done
    
    nextpage #page send mode
    send     #page send mode
done
