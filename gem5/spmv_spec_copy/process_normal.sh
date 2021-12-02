#!/bin/bash

. ./configs/configs_$1.sh

cd ${GEM5_PATH}

if [ ${SE_OR_FS} == SE ];then 
build/${ARCH}/gem5.${METHOD} --outdir=${SE_OUT_DIR_NORMAL} \
configs/example/se.py \
--cpu-type O3_ARM_v7a_3 \
--cpu-clock 3.1GHz \
--num-cpu 1 \
--caches --l2cache --l1i_size 64kB --l1d_size 64kB --l2_size 1MB \
--l1i_assoc 4 --l1d_assoc 4 --l2_assoc 4 --cacheline_size 128 \
--mem-type DDR4_2400_8x8 --mem-size 16GB \
-c ${SE_ELF_ROUTE} \
-o ${SE_INPUT_ROUTE} \
--param 'system.cpu[:].isa[:].sve_vl_se = 4'
elif [ ${SE_OR_FS} == FS ];then 
build/${ARCH}/gem5.${METHOD} --outdir=${FS_OUT_DIR_NORMAL} \
configs/example/fs.py \
--kernel ~/ChenRuiyang/gem5/full_system_images/binaries/vmlinux.arm64 \
--disk-image ~/ChenRuiyang/gem5/full_system_images/disks/ubuntu-18.04-arm64-docker.img \
--bootloader ~/ChenRuiyang/gem5/full_system_images/binaries/boot.arm64 \
--param "system.highest_el_is_64 = True" \
--cpu-type=O3_ARM_v7a_3 \
--mem-type DDR4_2400_8x8 --mem-size 16GB \
--cpu-clock=3.1GHz --num-cpu 1 --caches --l2cache \
--l1i_size 64kB --l1d_size 64kB --l2_size 1MB --l1i_assoc 4 \
--l1d_assoc 4 --l2_assoc 4 --cacheline_size 128 \
--param 'system.sve_vl = 4' --script ${FS_COMMAND};
else
echo SE_OR_FS should be SE or FS 
fi

