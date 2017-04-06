#!/usr/bin/env bash
# ##################################################
# Function:
# automatic test script
#
# Usage:
# Automatically called by system
#
# Copyright © 2016 Hustlion (hustlionm@qq.com)
#
#
# HISTORY:
#
# * 10-07-2016 - v1.0.0  - First Creation
#
# ##################################################

version="1.0.0"              # Sets version variable


mainFolder=20161013ubm_mix_eq

python UBM/ubmTrainer.py ~/$mainFolder/train/ ~/$mainFolder/train/

python Adaptation/adapter.py ~/$mainFolder/train ~/$mainFolder/train/

python Testing/test.py ~/$mainFolder/test ~/$mainFolder/trainmodel ~/$mainFolder/train/ubm.mixture-32.model

