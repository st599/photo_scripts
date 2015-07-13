#!/bin/bash
#######################################################################################
#
#	file		:	camera_card_backup.sh
#	date		:	13/07/2015
#	version		:	0.1 - Rsync
#			:	
#	requires	:	rsync
#	copyright	:	(c) st599 MMXV
#
#######################################################################################


echo "CAMERA CARD BACKUP shell script"
echo ""
echo " (c) st599 ver 0.1"
echo ""
echo "usage camera_card_backup.sh <input_directory>"

#####################
# INITIALISE        #
#####################

echo "...Initialise"

INPUT_DIR=$1

echo -n "......Input Directory: "
echo $INPUT_DIR

OUTPUT_DIR=~/camera_backup/`TZ='Europe/London' date +%y%m%d%H%M`/

echo -n "......Output Directory: "
echo $OUTPUT_DIR

#####################
# COPY              #
#####################

echo "...Copying"

rsync -uvh --progress $INPUT_DIR $OUTPUT_DIR

echo "......Copied"
