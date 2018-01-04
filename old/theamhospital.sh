#!/bin/sh
cd /home/fu-fu/.wine98/drive_c/Program\ Files/Bullfrog/Hospital/
echo "Hello"
pwd
echo `pwd`
WINEPREFIX=/home/fu-fu/.wine98 WINEARCH=win32 wine ./Hospital.exe 

