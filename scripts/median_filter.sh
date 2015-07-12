#!/bin/bash
#######################################################################################
#
#	file		:	median_filter.sh
#	date		:	12/07/2015
#	version		:	0.1 - Stack Align
#			:	0.2 - Median Filter
#	requires	:	hugin, dcraw
#	copyright	:	(c) st599 MMXV
#
#######################################################################################


echo "MEDIAN FILTER shell script"
echo ""
echo " (c) st599 ver 0.2"

#####################
# Image Frames      #
#####################

echo "...IMAGE FRAMES"

cd imageframes

# Convert Canon CR2 Frames to TIFF

echo "......Convert CR2 to Linear TIFF"

for file in *.CR2
do
	dcraw -T -4 $file
done

echo "......Align Image Stack"

fl='*.tiff'

align_image_stack -v -a ais $fl

echo "......Average Corrected Image Frames"

convert ais*.tif -alpha off -evaluate-sequence median -depth 16 final_median_filter.tiff

echo "......Convert to sRGB"

convert final_median_filter.tiff -set colorspace RGB -colorspace sRGB -depth 16 final_median_filter.tiff

mv final_median_filter.tiff ../

rm *.tiff

cd ..


