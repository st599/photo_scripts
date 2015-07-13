#!/bin/bash
#######################################################################################
#
#	file		:	camera_card_backup.sh
#	date		:	13/07/2015
#	version		:	0.1 - Rsync
#			:	0.2 - MD5sum
#	requires	:	rsync, md5sum
#	copyright	:	(c) st599 MMXV
#
#######################################################################################


echo "CAMERA CARD BACKUP shell script"
echo ""
echo " (c) st599 ver 0.2"
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

mkdir -p $OUTPUT_DIR


#####################
# COPY              #
#####################

echo "...Copying"
rsync -uvh --progress $INPUT_DIR $OUTPUT_DIR
echo "......Copied"


#####################
# CHECK             #
#####################

cd $IMPUT_DIR

for file in *
do
	echo "in: " `md5sum -cb $file` "  out: " `md5sum -cb $OUTPUT_DIR/$file`
done

