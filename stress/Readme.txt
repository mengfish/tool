1.Copy the whole stress test package to your machine.

2.Check your machine if has installed MSS Driver.

3.Execute mount.sh to mount streams to mediasdk_streams


4.Verify your stress streams path in smt_stress.par and copy the streams to your own path, if you don't use an absolute path, it may fail.


5.When running case, you can change the recycle in smt_stress.sh line 8.

6.After everything above get already, you can run the smt_stress.sh.

7.Use the sysinfo.sh to get  system detail information.

8.Check the result if normal by using check_result.sh during test or finished test.

Note:

1.you can add or reduce sessions in smt_stress.par if your machine performance isn't enough.

2.if the case interupted duing to unkown reason, if you need rerun, don't forget to remove the original log in logs directory, if you want to check the log if have errors, you can check with "zgrep -e 'count'  stress.log | wc -l "  and " zgrep -e 'The test PASSED'  stress.log | wc -l"
