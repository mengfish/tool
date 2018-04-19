#!/bin/bash
HOSTNAME=$(/usr/bin/hostname)

GPU_GT=$(./sysinfo | grep "gpu_gt" | awk -F "\"" '{print $4}')

MEMORY_SIZE=$(cat /proc/meminfo | grep "MemTotal" | awk -F " " '{print $2}')


kERNEL=$(/usr/bin/uname -r)

PLATFORM=$(lspci | grep "Host bridge" | awk -F ':' '{print $3}' | cut -d " " -f 4)

CPU=$(lscpu | grep "Model name" | awk -F ":" '{print $2}' | awk '{$1=$1;print}')

MEM=$(echo "$MEMORY_SIZE/1024/1024+0.5" | bc -l | cut -d "." -f 1)

MSS_DRIVER_VERSION=$(vainfo | grep "Driver version" | awk -F " " '{print $4}')

VAAPI_VERSION=$(vainfo | grep "VA-API version" | cut -d : -f 3)

MSDK_VERSION=$(strings /opt/intel/mediasdk/lib64/libmfxhw64.so | grep "mediasdk_product_version" | cut -d " " -f 2)

LIBDRM_VERSION=$(ls /opt/intel/mediasdk/opensource/libdrm/ | cut -d - -f 1)

printf "HOSTNAME: %s\n"  $HOSTNAME

printf "GPU_GT: %s\n"  $GPU_GT 

printf "PLATFORM: %s\n"  $PLATFORM

echo MEMTOTAL: $MEM G

printf "CPU: %s\n"  "$CPU"

printf "kERNEL: %s\n"  $kERNEL

printf "VAAPI_VERSION: %s\n"  "$VAAPI_VERSION"

printf "LIBDRM_VERSION: %s\n" "$LIBDRM_VERSION"
printf "MSDK_VERSION: %s\n"  "$MSDK_VERSION"

printf "MSS_DRIVER_VERSION: %s\n" $MSS_DRIVER_VERSION
