#!/bin/bash
Script_path=`pwd`

par_session=(
"-i::h264 $Script_path/mediasdk_streams/transcoder/H264/1920x1088_frm_cab_24mbs.264 -o::h264 720x576_800.264 -hw -async 5 -b 800 -h 576 -w 720"
"-i::h264 $Script_path/mediasdk_streams/transcoder/H264/1920x1088_frm_cab_24mbs.264 -o::h264 720x576_1600.264 -hw -async 5 -b 1600 -h 576 -w 720"
"-i::h264 $Script_path/mediasdk_streams/transcoder/H264/1920x1088_frm_cab_24mbs.264 -o::h264 720x576_12800.264 -hw -async 5 -b 12800 -h 576 -w 720"
"-i::h264 $Script_path/mediasdk_streams/transcoder/H264/1920x1088_frm_cab_24mbs.264 -o::h264 640x480_400.264 -hw -async 5 -b 400 -h 480 -w 640"
"-i::h264 $Script_path/mediasdk_streams/transcoder/H264/1920x1088_frm_cab_24mbs.264 -o::h264 640x480_6400.264 -hw -async 5 -b 6400 -h 480 -w 640"
"-i::vc1 $Script_path/mediasdk_streams/transcoder/VC1/VC1_640x480_CoralReef.vc1 -o::h264 CR_640x480_800.264 -hw -async 5 -b 800 -h 480 -w 640"
"-i::h264 $Script_path/mediasdk_streams/transcoder/H264/1920x1088_frm_cab_24mbs.264 -o::h264 352x288_200.264 -hw -async 5 -b 200 -h 288 -w 352"
"-i::h264 $Script_path/mediasdk_streams/transcoder/H264/1920x1088_frm_cab_24mbs.264 -o::h264 352x288_3200.264 -hw -async 5 -b 3200 -h 288 -w 352"
"-i::h264 $Script_path/mediasdk_streams/transcoder/H264/1920x1088_frm_cab_24mbs.264 -o::h264 176x144_100.264 -hw -async 5 -b 100 -h 144 -w 176"
"-i::h264 $Script_path/mediasdk_streams/transcoder/H264/1920x1088_frm_cab_24mbs.264 -o::h264 176x144_1600.264 -hw -async 5 -b 1600 -h 144 -w 176"
"-i::h264 $Script_path/mediasdk_streams/transcoder/H264/1920x1088_frm_cab_24mbs.264 -o::h264 1920x1080_1200.264 -hw -async 5 -b 1200 -h 1080 -w 1920"
"-i::h264 $Script_path/mediasdk_streams/transcoder/H264/1920x1088_frm_cab_24mbs.264 -o::mpeg2 1920x1080_2400.mpeg2 -hw -async 5 -b 9600 -h 1080 -w 1920"
"-i::h264 $Script_path/mediasdk_streams/transcoder/H264/1920x1088_frm_cab_24mbs.264 -o::h264 1920x1080_19200-LA.264 -hw -async 5 -la -lad 10 -b 19200 -h 1080 -w 1920"
"-i::mpeg2 $Script_path/mediasdk_streams/transcoder/MPEG2/kfp2_1920x1080i_60fps_15Mbps_u1s3l4_12157f.mpg -o::h264 1920x1080i_60f_1200.264 -hw -async 5 -b 1200 -h 1080 -w 1920"
)


echo ${par_session[0]} > smt_stress.par

for i in "${par_session[@]:1:13}"

do

	echo "$i" | tee -a smt_stress.par

done

chmod 777 smt_stress.par

