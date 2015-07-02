#!/bin/bash
#######################################################################################
#
#	file		:	astro_star_stacking.sh
#	date		:	02/07/2015
#	version		:	0.1 - Average Black Frames
#			:	0.2 - Subtract Black Frame from Star Frames
#			:	0.3 - Align star images
#			:	0.4 - Average star images
#	requires	:	hugin, dcraw
#	copyright	:	(c) st599 MMXV
#
#######################################################################################


echo "ASTRO STAR STACKING shell script"
echo ""
echo " (c) st599 ver 0.4"

#####################
# Black Frames      #
#####################

echo "...BLACK FRAMES"

cd blackframes

# Convert Canon CR2 Frames to TIFF

echo "......Convert CR2 to sRGB TIFF"

for file in *.CR2
do
	dcraw -T -6 $file
done

echo "......Average Black Frames"

convert *.tiff -alpha off -evaluate-sequence mean -depth 16 blackframe.tiff

echo "......Move Black Frame"

mv blackframe.tiff ../starframes

echo "......Tidy Up"

rm *.tiff

cd ..

#####################
# Star Frames       #
#####################

echo "...STAR FRAMES"

cd starframes

# Convert Canon CR2 Frames to TIFF

echo "......Convert CR2 to sRGB TIFF and Subtract Black File"

for file in *.CR2
do
	dcraw -T -6 $file
	composite -compose minus ${file%.CR2}.tiff blackframe.tiff -depth 16 corr_${file%.CR2}.tiff
done

echo "......Align Image Stack"

fl='corr*.tiff'

align_image_stack -v -a ais $fl

echo "......Average Corrected Star Frames"

convert ais*.tif -alpha off -evaluate-sequence mean -depth 16 final_stars.tiff

mv final_stars.tiff ../

rm *.tiff

cd ..


