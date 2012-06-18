#!/bin/bash

# SMOOTH applied a very light blurring filter to an image
# intended for projection onto the planetarium dome. Because
# of the projection and the resolution of the projector,
# individual pixels can be obviously visible and this makes
# aliasing effects especially bad when projecting an image
# with small text.

image=$1
smoothed="smoothed_${image}"

convert $image -blur 0x8 $smoothed
