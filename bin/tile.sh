#!/bin/bash

convert $1 0.png
convert $1 -rotate 90 90.png
convert $1 -rotate 180 180.png
convert $1 -rotate 270 270.png
montage null: 180.png null: 90.png null: 270.png null: 0.png null: -geometry 800x800\>+1+1 -tile 3x3 -background black output.png
rm 0.png 90.png 180.png 270.png
