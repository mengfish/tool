#!/bin/bash
[[ -d `pwd`/logs ]] || mkdir `pwd`/logs

log_out=`pwd`/logs

start_time=$(date +%s) || date "+%Y-%m-%d %H:%M:%S" | tee -a  $log_out/stress.log

Script_path=`pwd`

Check_stream=$(du -s mediasdk_streams/ | awk '{print $1}')

VAINFO=$(vainfo | echo $?)

if [ "$VAINFO" = "0" ]

then

        echo "Your MSS Driver has been installed. "

else

        echo "Sorry, please check your mss driver version. "

        exit $?

fi


if [ "$Check_stream" == 0 ]

then

	echo "Please check if the streams has been mounted."
	
	echo "you can use command 'sh mount.sh' to resolve this problem."
	
	exit 0
fi

#generate smt_stress.par file.
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

#Start test

for ((i=1;i<=3;i++ ))

do
	echo "+++++++++++++++count$i++++++++++++++++++" | tee -a  $log_out/stress.log 
	echo "Start at `date '+%Y-%m-%d %H:%M:%S'` " | tee -a  $log_out/stress.log
	./sample_multi_transcode -par  smt_stress.par  2>&1 | tee -a $log_out/stress.log
	echo "This is your $i time to run case" | tee -a  $log_out/stress.log
	echo "End at `date '+%Y-%m-%d %H:%M:%S'` " | tee -a  $log_out/stress.log
	
	echo "+++++++++++++++++++++++++++++++++" | tee -a  $log_out/stress.log 
	echo -e "\n\n"
done

#after test finished. check the result if pass.

Total_run=$(zgrep -e "count"  $log_out/stress.log | wc -l)
Pass_run=$(zgrep -e "The test PASSED" $log_out/stress.log | wc -l)
Fail_run=$(($Total_run-Pass_run))

echo "Total run $Total_run times, Pass times:$Pass_run, Fail times:$Fail_run." | tee -a  $log_out/stress.log

if [ "$Pass_run" = "$Total_run" ]

then
        echo "Stress test pass." | tee -a  $log_out/stress.log
else

        echo "Stress test fail." | tee -a  $log_out/stress.log
fi

#caculate test spend time.

end_time=$(date +%s) || date "+%Y-%m-%d %H:%M:%S" | tee -a  $log_out/stress.log

spend_time=$(($end_time - start_time))

duration=`echo "scale=5;$spend_time/60/60" | bc`

echo "you spend  $duration h to run case" | tee -a $log_out/stress.log

rm -rf *.264
rm -rf 1920x1080_2400.mpeg2
