#!/usr/bin/env bash
# ##################################################
# Function:
# number normal to be 1 to 1000, abnormal to be 2000+
#
# Usage:
# ./numberBiClass.sh min max path
#
# Copyright © 2016 Hustlion (hustlionm@qq.com)
#
#
# HISTORY:
#
# * 10-13-2016 - v1.0.0  - First Creation
#
# Known Bugs:
# 
#
#
# TODO:
# 
# ##################################################

version="1.0.0"              # Sets version variable

# read args
numMin=$1
numMax=$2
folders=$(find $3 -type d -name "[0-9]*")

tmpNum=$numMin || 1

# tmp number
# in case there is name conficts
for folder in ${folders[*]}
do
  let tmpNum++
  echo "Num is ：",$tmpNum
  destFolder=`dirname $folder`/$tmpNum
  echo "old file is :",$folder,"new file 's name is :"$destFolder
  mv $folder $destFolder
done

# final touch
##tmpFolders=$(find $3 -type d -regex ".*[0-9]")
#for folder in ${tmpFolders[*]}
#do
#  finalName=$(echo $folder | perl -pe 's/(.*)(tmp)(\d+)/\1\3/')
#  echo $finalName
#  mv $folder $finalName
#done




