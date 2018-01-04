i=0
while [ $i -lt $1 ]  ; do
let i++
xdotool keydown ctrl
xdotool click 1
xdotool mousemove_relative 0 -65
xdotool click 1
xdotool keyup ctrl
xdotool mousemove_relative 0 65
xdotool key Delete
done

