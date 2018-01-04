cd ~/pics
while true; do
wget -O wall.jpg "https://quotefancy.com/download/"$RANDOM"/original/wallpaper.jpg" && break
done
fbsetbg wall.jpg
