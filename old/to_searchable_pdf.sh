##Param 1: Directory with all .tiff's in correct order.

if [ -e $1/in_progress ]; then exit ; fi

#Convert args1:
ARGS1=" -auto-orient -deskew 40 -gravity Center -crop 2480x3508+0+0 +repage -threshold 60% -quality 00"
#Convert the pictures:
MYRANDOM=$RANDOM
WORKDIR=./TMP_$MYRANDOM
mkdir $WORKDIR -p

touch $1/in_progress

for i in `ls $1`; do 
#	cp $1/$i $WORKDIR/$i #FOR DEBUGING
	convert $1/$i  $ARGS1 $WORKDIR/$i.png
	pngcrush -brute -q $WORKDIR/$i.png $WORKDIR/$i.crushed.png
	rm	$WORKDIR/$i.png
done

cd $WORKDIR
mkdir tess
cd tess

FIRST=1
for i in `ls ../`; do 
	tesseract ../$i $i pdf
	if [ $FIRST == 1 ]; then
		echo "FIRST"
		FIRST=0
		mv $i.pdf out.pdf
		mv $i.txt out.txt
	else
		cat $i.txt >> out.txt
		pdfunite out.pdf $i.pdf newout.pdf
		mv newout.pdf out.pdf
		rm $i.pdf $i.txt
	fi
done

