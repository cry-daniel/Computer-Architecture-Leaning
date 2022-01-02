#!/bin/bash

NAME=$1

. ./configs/configs_${NAME}.sh

if [ ${SE_OR_FS} == SE ];then
# 下面两行是清空记录的数据的文件夹
rm -r ${REC_ROUTE}/${SE_NAME}/${SE_NAME}_${SE_SUFFIX};
mkdir ${REC_ROUTE}/${SE_NAME};
mkdir ${REC_ROUTE}/${SE_NAME}/${SE_NAME}_${SE_SUFFIX};
# times 是读写了多少个 checkpoint
times=$(ls ${GEM5_PATH}/${SE_OUT_DIR_CHECKPOINT} | wc -l)
# times-4 是因为有 config.ini,config.js,fs,stats.txt
for ((i=1;i<=times-4;i++))
# 对每一个 checkpoint 做 reload
do cd ${SH_ROUTE};nohup time bash sim_reload.sh $i ${NAME} > ${REC_ROUTE}/${SE_NAME}/${SE_NAME}_${SE_SUFFIX}/$i.txt &
done

else
echo SE_OR_FS should be SE 
fi

# 将完成的结果写到文件里面
echo ${SE_NAME}_${SE_SUFFIX} has been done! >> /home/data/ChenRuiyang/time_rec/done_tests.txt