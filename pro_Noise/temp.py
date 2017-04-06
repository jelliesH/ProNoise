# -*- coding: utf-8 -*-
"""
Spyder Editor

This is a temporary script file.
"""
import os

def GetFileList(dir):
    newDir = dir
    if os.path.isfile(dir):
        namelist=os.path.basename(dir)
        newname_list=namelist.replace(' ','_')
        newname_list=newname_list.replace('（','_')
        newname_list=newname_list.replace(' ）','_')
        newname_list=newname_list.replace('(','_')
        newname_list=newname_list.replace(')','_')
        #old_name = os.path.join(dir,namelist)
        #new_name = os.path.join(dir,newname_list)
        path = os.path.split(dir)[0]
        os.chdir(path) 
        cmd = "mv '"+namelist+"' "+newname_list
        print cmd
        os.system(cmd)
    elif os.path.isdir(dir):
        for s in os.listdir(dir):
            # 如果需要忽略某些文件夹，使用以下代码
            # if s == "xxx":
            # continue
            newDir = os.path.join(dir, s)
#	  newDir = newDir.encode("utf-8")
            GetFileList(newDir)
    return "Susscess !"

#if  __name__  == 'main':
#dir1 = sys.argv[0]
#    dir='/home/390771/Project/noise/audiolib_feature/hh'
#    dir1='/home/390771/Project/noise/audiolib_feature/hh/14_名义制冷  风机60Hz，压机1 20Hz，压机2 34Hz      右面.mfcc'
#GetFileList(dir)

