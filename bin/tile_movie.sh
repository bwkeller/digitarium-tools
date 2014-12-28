#!/bin/sh
#
# MovieSplitter - A W.J. McCallion Planetarium application for converting video files that
#  play on the East and West sides of the domed ceiling instead of directly overhead.
#
# Written by: Mikhail Klassen
#
# Requirements: ffmpeg, imagemagick
#
# Calling sequence:
#    ./moviesplitter movie_filename
#
# The output will look like "movie_filename_twoview.mpg"
#
# N.B.: All output movies are in the MPEG-2 video file format, which we know the planetarium
#       computer is capable of playing. The input file format requirements depend only on the
#       codecs that ffmpeg is preloaded with on your system.

input=$1
outfile=${input%.*}_twoview.mpg

dirname='extracted_frames_tmp'

echo "Creating temporary directory to store frames"

mkdir $dirname

echo "Extracing frames from movie into temporary directory"

ffmpeg -i $input -r 25 -f image2 $dirname/images%05d.jpg

echo " "
echo " "
echo "Converting each frame to a two-views version"
echo " "

progress="0"
finalcount=$(find $dirname/*.jpg | wc -l )
percent="0"


echo " "
echo "Progress: "
echo "|---------|---------|---------|---------|------50%|---------|---------|---------|---------|-----100%|"
echo -n "|"

for j in $(ls $dirname/*.jpg)
do
    if [ $(( $progress*100/$finalcount )) -gt $percent ]; then
echo -n '-'
        percent=$(( $percent + 1 ))
    fi

    # Prepare temporary, rotated images
    convert $j -background black -rotate 90 leftimage.jpg
    convert $j -background black -rotate 270 rightimage.jpg
    
    # Make montage
    montage null: null: null: leftimage.jpg null: rightimage.jpg null: null: null: -geometry 600x600 -background black $j
    
    # Clean up
    rm -f rightimage.jpg
    rm -f leftimage.jpg

    progress=$(( $progress + 1 ))
done
echo "|"
echo " "

echo "Rebuilding the movie file (MPEG-2 format)"

#ffmpeg -i $dirname/images%05d.jpg -r 25 -f mpeg2video $outfile
mencoder "mf://frames/*.jpg" -mf fps=25 -o test.avi -ovc lavc -lavcopts vcodec=msmpeg4v2:vbitrate=800 
ffmpeg -i temp_out.avi -r 25 $outfile
rm -f temp_out.avi

echo "Cleaning up temporary frames directory"

rm -rf $dirname
