#!/usr/bin/env bash
##预处理后最终得到结果：
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
#把audiolib_feature/errNoise/ 与 audiolib_feature/norNoise/ 下的所有文件混在一起见新目录结构

:'
 noise/
	  audiolib/ 
		      errNoise/
				***.WAV ...
			norNoise/
				***.WAV ...
	  audiolib_feature/

			mixture_err_nor_Noise/

				2/				
				    ***.mfcc ...
				3/				
				    ***.mfcc ...
				...

				2001/				
				    ***.mfcc ...
				2002/				
				    ***.mfcc ...
				...				
'
# UBM训练
#特征路径/输出ubm模型路径

python UBM/ubmTrainer.py home/390771/Project/noise/feature_file/mixture_err_nor_Noise/ home/390771/Project/noise/feature_file/mixture_err_nor_Noise/

## 训练每个类别的模型

python Adaptation/adapter.py /home/390771/Project/noise/feature_file/mixture_err_nor_Noise /home/390771/Project/noise/feature_file/mixture_err_nor_Noise /home/390771/Project/noise/feature_file/mixture_err_nor_Noise /home/390771/Project/noise/feature_file/mixture_err_nor_Noise/

## 进行测定

path = /home/390771/Project/noise/feature_file/mixture_err_nor_Noise

path_model = /home/390771/Project/noise/feature_file/mixture_err_nor_Noise_model

path_model_ubm = /home/390771/Project/noise/feature_file/mixture_err_nor_Noise/ubm.mixture-32.model

python Testing/test.py $path $path_model $path_model_ubm

#结果分类 

cat result-noise.txt | grep ".*\s.*\s.*" | sort -n | awk '{if($1>1 && $1<1000) { if ($2<1000) {print $1 " 1 " $3} else {print $1 " 0 " $3} } else if($1>2000){if($2>2000){print $1 " 1 " $3}else{ print $1 " 0 " $3}}}'

:'
把实验的结果文件先输出，然后用正则表达式取类似于“2 3 2.mfcc”的行，然后按第一个字段排序，然后根据1、2列的数值来判定输出最后的结果。因为正常文件编号1-1000，异常文件编号2000以上，所以设定相应变量判定结果。

最终输出结果为多行数据，每行三个字段：真实标签 判定标签 文件名
'
