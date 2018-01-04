#!/bin/sh
SOURCE=pamphlet-low.pdf # set to the file name of the PDF
OUTPUT=pamphlet-low # set to the final output file
RESOLUTION=300 # set to the resolution the scanner used (the higher, the better)
#IN DPI

SOURCE=$1
OUTPUT=$2

PRTMP="/tmp/page"
SUTMP="png"

if [ $3 ]; then
	IINIT=$3
else
	IINIT=1
fi

if [ $4 ]; then
	PAGES=$4
else
	PAGES=`convert $SOURCE[999999] /tmp/page.png 2>/dev/null | grep "number of pages" | cut -d":" -f 2 | cut -d" " -f 2`
fi
echo $PAGES" pages"
j=0
for i in `seq $IINIT $PAGES`; do
	
    convert -density $RESOLUTION -depth 8 $SOURCE\[$(($i - 1 ))\] $PRTMP.$i.$SUTMP
    tesseract $PRTMP.$i.$SUTMP $OUTPUT.$i pdf #hocr
	rm	$PRTMP.$i.$SUTMP
#	rm $OUTPUT.$j.pdf & 
	if [ $i = '1' ]; then
		echo "First"
		mv	$OUTPUT.$i.pdf	$OUTPUT.f.$i.pdf 
		mv	$OUTPUT.$i.txt	$OUTPUT.txt 
	else	
		cat	$OUTPUT.$i.txt	>> $OUTPUT.txt && rm $OUTPUT.$i.txt
		pdfunite  $OUTPUT.f.$j.pdf $OUTPUT.$i.pdf $OUTPUT.f.$i.pdf && \
		echo "$i Done!" && \
		rm	$OUTPUT.f.$j.pdf $OUTPUT.$i.pdf
		#WITHOUT REMOVEING THESE, it will take huge ammounts of space 
	fi
	echo $i > $OUTPUT.progress
	j=$i
done

