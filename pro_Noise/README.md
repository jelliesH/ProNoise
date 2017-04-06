#噪音分析

#依赖安装：
pip install -r requirements.txt

#音频特征提取

#在项目根目录下执行：

./mfccExtractor/mfccExtract.py /Volumes/Knowledge/Projects/tmp/training

./mfccExtractor/mfccExtract.py /home/390771/Project/noise/audiolib

# 数据形式准备

python temp_1.py /home/390771/Project/noise/audiolib_feature/errNoise
python temp_1.py /home/390771/Project/noise/audiolib_feature/norNoise

## 将每个文件放入独立的文件夹中

```shell
# find all the mfcc file and create a folder for it

#find . -name "*.mfcc" -exec basename {} .mfcc \; |awk '{cmd="mkdir "$0" && cp "$0".mfcc ./"$0;system(cmd)}'
```


#find ./norNoise -name "*.mfcc" -exec basename {} .mfcc \; |awk '{cmd="mkdir ./feature_file/norNoise/"$0" ; cp ./norNoise/"$0".mfcc ./feature_file/norNoise/"$0;system(cmd)}'

find /home/390771/Project/noise/audiolib_feature/errNoise  -name "*.mfcc" -exec basename {} .mfcc \; |awk '{cmd="mkdir /home/390771/Project/noise/feature_file/errNoise/"$0" ; cp /home/390771/Project/noise/audiolib_feature/errNoise/"$0".mfcc /home/390771/Project/noise/feature_file/errNoise/"$0;system(cmd)}'

find /home/390771/Project/noise/audiolib_feature/norNoise  -name "*.mfcc" -exec basename {} .mfcc \; |awk '{cmd="mkdir /home/390771/Project/noise/feature_file/norNoise/"$0" ; cp /home/390771/Project/noise/audiolib_feature/norNoise/"$0".mfcc /home/390771/Project/noise/feature_file/norNoise/"$0;system(cmd)}'

## 对文件进行统一编号

./numberBiClass.sh 1 1000 /home/390771/Project/noise/feature_file/errNoise
./numberBiClass.sh 2000 3000 /home/390771/Project/noise/feature_file/norNoise

./numberBiClass.sh 1 1000 /Volumes/Knowledge/Projects/tmp/beta_subclass/processed/train_numbered_normal
./numberBiClass.sh 2000 3000 /Volumes/Knowledge/Projects/tmp/beta_subclass/processed/train_numbered_abnormal

##将 feature_file/errNoise 和 feature_file/norNoise的编号文件混在一起命名为 mixture_err_nor_Noise

# UBM训练
#特征路径/输出ubm模型路径
/home/390771/Project/noise/feature_file/mixture_err_nor_Noise/
## 训练ubm模型
python UBM/ubmTrainer.py ~/20161007/500K/ ~/20161007/500K/ 

第一个参数为特征路径，第二个参数为ubm模型输出路径

## 训练每个类别的模型
/home/390771/Project/noise/feature_file/mixture_err_nor_Noise /home/390771/Project/noise/feature_file/mixture_err_nor_Noise/

python Adaptation/adapter.py ~/20161007/500K ~/20161007/500K/

第一个参数为特征路径，第二个参数为ubm模型所在路径
注意第一个路径不给斜杠。

## 进行测定

/home/390771/Project/noise/feature_file/mixture_err_nor_Noise

/home/390771/Project/noise/feature_file/mixture_err_nor_Noise_model

/home/390771/Project/noise/feature_file/mixture_err_nor_Noise/ubm.mixture-32.model

python Testing/test.py ~/20161007/testSuite ~/20161007/500Kmodel ~/20161007/500K/ubm.mixture-32.model

第一个参数为特征路径，第二个参数为每个类别的模型路径，第三个参数为ubm模型输出路径

# 结果分析（子类）

```shell
# 1000 2000 
cat result-noise.txt | grep ".*\s.*\s.*" | sort -n | awk '{if($1>1 && $1<1000) { if ($2<1000) {print $1 " 1 " $3} else {print $1 " 0 " $3} } else if($1>2000){if($2>2000){print $1 " 1 " $3}else{ print $1 " 0 " $3}}}'
```
把实验的结果文件先输出，然后用正则表达式取类似于“2 3 2.mfcc”的行，然后按第一个字段排序，然后根据1、2列的数值来判定输出最后的结果。因为正常文件编号1-1000，异常文件编号2000以上，所以设定相应变量判定结果。

最终输出结果为多行数据，每行三个字段：真实标签 判定标签 文件名

可以据此统计得到最后结果。

