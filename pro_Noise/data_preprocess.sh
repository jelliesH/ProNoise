#!/usr/bin/env bash
#依赖安装：
pip install -r requirements.txt
#----特征提取---- 
#源目录结构
:'noise/
	  audiolib/ 
		      errNoise/
				***.WAV ...
			norNoise/
				***.WAV ...
'
#项目文件下运行
./mfccExtractor/mfccExtract.py /home/390771/Project/noise/audiolib
#新产生的audiolib_feature见目录结构
:'
  noise/
	  audiolib/ 
		      errNoise/
				***.WAV ...
			norNoise/
				***.WAV ...
	  audiolib_feature/
			errNoise/
				***.mfcc ...
			norNoise/
				***.mfcc ...
'
#把每个音频经过mfcc处理后的特征存为“音频名.mfcc”文件，其中音频名称与源音频名一致
#源音频的文件名有不规范，名称中含有空格/括号/，为此将新转化成的特征文件名称带有空格/括号的标识符替换成"_"

python temp_1.py /home/390771/Project/noise/audiolib_feature/errNoise
python temp_1.py /home/390771/Project/noise/audiolib_feature/norNoise

#将目录audiolib_feature/errNoise/ 和 audiolib_feature/norNoise/ 下的***.mfcc文件放到同名下的文件夹里面

find /home/390771/Project/noise/audiolib_feature/errNoise  -name "*.mfcc" -exec basename {} .mfcc \; |awk '{cmd="mkdir /home/390771/Project/noise/feature_file/errNoise/"$0" ; cp /home/390771/Project/noise/audiolib_feature/errNoise/"$0".mfcc /home/390771/Project/noise/feature_file/errNoise/"$0;system(cmd)}'

find /home/390771/Project/noise/audiolib_feature/norNoise  -name "*.mfcc" -exec basename {} .mfcc \; |awk '{cmd="mkdir /home/390771/Project/noise/feature_file/norNoise/"$0" ; cp /home/390771/Project/noise/audiolib_feature/norNoise/"$0".mfcc /home/390771/Project/noise/feature_file/norNoise/"$0;system(cmd)}'


##得到结果：
:'
 noise/
	  audiolib/ 
		      errNoise/
				***.WAV ...
			norNoise/
				***.WAV ...
	  audiolib_feature/

			errNoise/
				***/				
				    ***.mfcc ...
				...
			norNoise/
				***/				
				    ***.mfcc ...
				...
'


## 对文件进行统一编号，目的是为了以后训练用

./numberBiClass.sh 1 1000 /home/390771/Project/noise/feature_file/errNoise
./numberBiClass.sh 2000 3000 /home/390771/Project/noise/feature_file/norNoise

##最终得到结果：
:'
 noise/
	  audiolib/ 
		      errNoise/
				***.WAV ...
			norNoise/
				***.WAV ...
	  audiolib_feature/

			errNoise/
				2/				
				    ***.mfcc ...
				3/				
				    ***.mfcc ...
				...
			norNoise/
				2001/				
				    ***.mfcc ...
				2002/				
				    ***.mfcc ...
				...				

'





