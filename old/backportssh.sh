while true;
do
ssh 68.147.193.221 -X -Y -C -p 443 -l fu-fu -D 4434 -R 4435:localhost:22
done
