#!/bin/bash
#######################################################################################
#
#	file		:	camera_profile_colourChecker.sh
#	date		:	03/06/2017
#	version		:	0.1 - Initial
#	requires	:	darktable
#	copyright	:	(c) st599 MMXVII
#
#######################################################################################


echo "CAMERA PROFILE WITH COLORCHECKER shell script"
echo ""
echo " (c) st599 ver 0.1"
echo ""

echo "    Input File: " $1

echo "    Use darktable:"
echo "      Set input and output colour profile to Linear Rec.709 RGB"
echo "      Set output intent to Absolute Colorimetric"
echo "      Switch Base Curve and Highlight reconstruction off"
echo "      Use Color Picker and exposure to increase L value of White square to greater than 90"
echo "      Crop and rotate so that you have only the Color Checker in Shot"
echo "      Export 16bit uncompressed TIFF with filename " ${1%.*}.tif
echo "      Close Darktable"

darktable $1

cp /usr/share/color/argyll/ref/ColorChecker.* .
scanin -v -p -a -G 1.0 -dipn ${1%.*}.tif ColorChecker.cht ColorChecker.cie
colprof -v -A "Canon" -M "EOS 700D" -D "Canon EOS 700D Tungsten Test" -qh -am -nc -u ${1%.*}
mkdir -p ~/.config/darktable/color/
mkdir -p ~/.config/darktable/color/in/
cp *.icc ~/.config/darktable/color/in/

