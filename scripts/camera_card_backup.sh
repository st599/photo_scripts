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

OUTPUT_DIR=~/Camera_Backup/`TZ='Europe/London' date +%y%m%d%H%M`/

echo -n "......Output Directory: "
echo $OUTPUT_DIR

mkdir -p $OUTPUT_DIR
cd $INPUT_DIR

#####################
# COPY              #
#####################

echo "...Copying"
rsync -vv -u -a --progress $INPUT_DIR $OUTPUT_DIR
echo "......Copied"


#####################
# CHECK             #
#####################

cd $INPUT_DIR

echo "...Checking File"
for f in * 
do 
	[[ -f $f ]] && if [ $(md5sum "$f" | cut -d" " -f1) == $(md5sum $OUTPUT_DIR/"$f" | cut -d" " -f1) ] 
	then 
		echo "......" "$f" "OK"
	else 
		echo "......" "$f" "MODIFIED"
	fi 
done

echo "......Checks Complete"

