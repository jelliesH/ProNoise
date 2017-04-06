#!/usr/bin/env bash
# ##################################################
# Function:
# give the final bisecting result
#
# Usage:
# Automatically called by system
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

# read result
cat result-noise.txt | grep ".*\s.*\s.*" | sort -n ) | \
awk '{if($1>1 && $1<1000)\
{ if ($2<9) \
  {print 1} \
  else {print 0} }}'

cat result-noise.txt | grep ".*\s.*\s.*" | sort -n ) | \
awk '{
    if($1>1 && $1<9){
        if ($2<9) {
            print $1 " 1 " $3
        } else {
            print $1 " 0 " $3
        }
    } else if($1>20){
        if($2>20){
            print $1 " 1 " $3
        } else {
            print $1 " 0 " $3
        }
    }
}'

cat result-noise.txt | grep ".*\s.*\s.*" | sort -n | awk '{if($1>1 && $1<9) { if ($2<9) {print $1 " 1 " $3} else {print $1 " 0 " $3} } else if($1>20){if($2>20){print $1 " 1 " $3}else{ print $1 " 0 " $3}}}'

# judge the normal


# judge the abnormal

# output to txt file




