#!/bin/bash

# FISHEYE applies a barrel distortion filter to an image to correct for
# the planetarium's spherical fisheye lens so that projected images 
# display as intended.

# From the ImageMagick website:
# http://www.imagemagick.org/Usage/lens/
#
# The barrel distortion is defined by the mathematical formula
#
#  R = (a * r^3 + b * r^2 + c^r + d) * r
#
# with r as the distance to the geometrical image center of the digital photograph and R as the equivalent radius for the corrected image.
# The radii r and R are normalised by half of the smaller image dimension, such that r = 1 for the midpoints of the equivalent edges of 
# the photograph. When correcting digital photographs, we should pay attention to the non-scaling restraint
#
#  a + b + c + d = 1
#
# which obviously gives a result of R = 1 when the input r = 1. Panorama Tools calculates the parameter d by the other parameters via
#
#  d = 1 - a - b - c
#
# leaving us with three free model parameters, so the parameter d is typically omitted. IM can calculate this automatically if not provided.
#
# See also: http://www.imagemagick.org/Usage/distorts/#barrel

# The distortion parameters
# WARNING: These have not yet been calibrated to the planetarium!

a=0.0
b=0.0
c=-0.2
d=1.4

# To do: make optional command line arguments for custom a, b, c, d parameters

image=$1
corrected="corrected_${a}_${b}_${c}_${d}_${image}"

# Note: D is an optional parameter, but giving it a value larger than 1.0 shrinks the image slightly so that the corrected image does
# not have its corners cut off. See http://www.imagemagick.org/Usage/distorts/#barrel

convert $image -virtual-pixel black \
	-distort Barrel "$a $b $c $d" $corrected
