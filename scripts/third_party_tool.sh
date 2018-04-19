#!/bin/bash
if [ `id -u` -eq 0 ]
then
echo "ok!you can install your software now!"
else
echo "sorry,you must use root!"
exit 0
fi

TOOL_PATH=`pwd`/third_party_tool

if [ -d $TOOL_PATH ]
then
rm -rf $TOOL_PATH
fi
if [ ! -e third_party_tool.zip ]
then
echo "third_party_tool.zip doesn't exist! please check your package." >> $TOOL_PATH/../install_version.log
else 
unzip third_party_tool.zip
fi

chmod 777 -R $TOOL_PATH

set timeout 5;

#valgrind --version > log.txt
#cat log.txt | grep valgrind-3.11.0
valgrind_version=$(valgrind --version)
if [ "$valgrind_version" == "valgrind-3.11.0"  ]
then
echo "valgrind installed version is valgrind-3.11.0 before. " >> $TOOL_PATH/../install_version.log
else
yum -y install valgrind

#cat log.txt | grep valgrind-3.11.0
valgrind_version=$(valgrind --version)
if [ "$valgrind_version" == "valgrind-3.11.0" ]
then
echo "valgrind3.11.0 install successfully." >> $TOOL_PATH/../install_version.log
else 
echo "valgrind3.11.0 doesn't install successfully." >> $TOOL_PATH/../install_version.log
#exit $?
fi

fi

#rm -rf `pwd`/log.txt

#rpm -qa | grep xerces-c | grep xerces-c-3.1.1
xerces_version=$(rpm -qa | grep xerces-c | grep xerces-c | awk -F '-' '{print $3}')
if [ "$xerces_version" == "3.1.1" ]
then
echo "xerces-c installed version is xerces-c-3.1.1 before." >> $TOOL_PATH/../install_version.log
else
yum -y install xerces-c
#rpm -qa | grep xerces-c | grep xerces-c-3.1.1
xerces_version=$(rpm -qa | grep xerces-c | grep xerces-c | awk -F '-' '{print $3}')
if [ "$xerces_version" == "3.1.1" ]
then
echo "xerces-c3.1.1 install successfully." >> $TOOL_PATH/../install_version.log
else
echo "xerces-c3.1.1 doesn't install successfully." >> $TOOL_PATH/../install_version.log
#exit $?
fi

fi



#yasm --version | grep 1.3.0
yasm_version=$(yasm --version | grep 1.3.0 | awk -F ' ' '{print $2}')
if [ "$yasm_version" == "1.3.0" ]
then
echo "yasm installed version is 1.3.0 before." >> $TOOL_PATH/../install_version.log
else
	cd $TOOL_PATH/MPlayer-1.1.1/yasm-1.3.0 
	./configure
	make 
	make install
#yasm --version | grep 1.3.0
	yasm_version=$(yasm --version | grep 1.3.0 | awk -F ' ' '{print $2}')
	if [ "$yasm_version" == "1.3.0" ]
	then
		echo "yasm1.3.0 install successfully." >> $TOOL_PATH/../install_version.log
	else
		echo "yasm1.3.0 doesn't install successfully." >> $TOOL_PATH/../install_version.log
	fi

fi


set timeout 5;

#mplayer -v | grep 1.1-4.8.5
mplayer_version=$(mplayer -v | grep MPlayer | awk -F ' ' '{print $2}')
if [ "$mplayer_version" == "1.1-4.8.5" ]
	then
	echo "mplayer installed version is 1.1-4.8.5 ." >> $TOOL_PATH/../install_version.log

	else
		cd $TOOL_PATH/MPlayer-1.1.1/MPlayer-1.1.1 
		./configure
		make
	make install

	#mplayer -v | grep 1.1-4.8.5
	mplayer_version=$(mplayer -v | grep MPlayer | awk -F ' ' '{print $2}')
	if [ "$mplayer_version" == "1.1-4.8.5" ]
	then
		echo "mplayer1.1.1 install successfully." >> $TOOL_PATH/../install_version.log
	else
	echo "mplayer1.1.1 doesn't install successfully." >> $TOOL_PATH/../install_version.log
	
	fi

fi

set timeout 5;

ffmpeg_version=$(ffmpeg -version |grep "ffmpeg"|awk -F ' ' ' {print $3}')

if [ "$ffmpeg_version" == "2.0.2" ]
	then
	echo "ffmpeg  installed version is 2.0.2." >> $TOOL_PATH/../install_version.log
	else
	cd $TOOL_PATH/ffmpeg-2.0.2 
	./configure
	make 
	make install

	ffmpeg_version=$(ffmpeg -version |grep "ffmpeg"|awk -F ' ' ' {print $3}')
	if [ "$ffmpeg_version" == "2.0.2" ]
	then
		echo "ffmpeg2.0.2  install successfully." >> $TOOL_PATH/../install_version.log
	else
		echo "ffmpeg2.0.2  doesn't install successfully." >> $TOOL_PATH/../install_version.log

	fi

fi

set timeout 5;

#mediainfo --version > log.txt

#cat log.txt | grep  v0.7.87

mediainfo --version | grep v0.7.87
if [ $? -eq 0 ]
then
	echo "mediainfo  installed version is v0.7.87." >> $TOOL_PATH/../install_version.log
	else
	cd $TOOL_PATH/mediainfo
	rpm -Uvh *.rpm
	mediainfo_version=$(mediainfo --version |grep "v"|awk -F '-' '{print $2}')
	if [[ "$mediainfo_version" == " v0.7.87" ]] 
	then
		echo "mediainfo v0.7.87 install successfully." >> $TOOL_PATH/../install_version.log
	else
	echo "mediainfo v0.7.87 doesn't install successfully." >> $TOOL_PATH/../install_version.log
	fi
fi



#rm -rf `pwd`/log.txt


#rm -rf $TOOL_PATH