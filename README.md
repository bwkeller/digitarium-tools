digitarium-tools
================

A few scripts and tools for users of Digitalis planetarium systems.  This package includes 
both scripts for running on the planetarium system (using the stratoscript language) and 
a few Unix utilities for working with a Digitarium planetarium.

bin/
----------------
This directory contains a few shell scripts and short utilities for working with the 
planetarium.

* tile.sh
	* This is a small bash script that uses imagemagick to tile 4 copies of an image onto
	the four quadrants of the dome.

scripts/
----------------
This directory contains stratoscript planetarium scripts for use with the Nightshade 
planetarium software.

* gliese.sh
    * This script shows the Gliese 581 system, which contains a number of 
    intersesting exoplanets.
