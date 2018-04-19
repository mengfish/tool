#!/bin/bash

log_out=`pwd`/logs

if [ ! -d "$log_out" ];then

        echo "Sorry, there is no such a file or directory."
        echo "Please check your log path."
        exit 0
fi

status_stress=$(ps aux | grep  "smt_stress.par" | sed -n 1p | awk -F " " '{print $13}')

start_time=$(grep -r  "Start at" $log_out/stress.log | sed -n 1p)

end_time=$(grep -r  "End at" logs/stress.log | sed -n '$p')

count=$(zgrep -e "count"  $log_out/stress.log | wc -l)

Pass_run=$(zgrep -e "The test PASSED" $log_out/stress.log | wc -l)

echo $start_time

echo $end_time

if [  "$status_stress" = "smt_stress.par"  ]
then
	echo "The test is running."
	Total_run=$(($count-1))
	Fail_run=$(($Total_run-$Pass_run))
	echo Total run $Total_run

else
	echo "Stress is not running."
	Total_run=$count
	Fail_run=$(($Total_run-$Pass_run))
	echo Total run $Total_run

fi
	
echo "Fail times are:  " $Fail_run

echo "Total run $Total_run times, Pass times:$Pass_run, Fail times:$Fail_run." 

if [ "$Pass_run" = "$Total_run" ]

then
        echo "Stress test pass." 
else

        echo "Stress test fail."
fi


