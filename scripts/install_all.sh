#!/bin/sh

if [ `whoami` = 'root' ]

then
        echo "ok!you can install your software now!"
else
 
       echo "sorry,you must use root!"
       exit 0
fi

#set proxy
export | grep proxy
if [ $? -eq 0 ]
then
echo 'proxy set already.'
else
sed -i '$ a\\ export https_proxy=https://proxy-prc.intel.com:911\n export http_proxy=http://proxy-prc.intel.com:911' ~/.bashrc
sed -i '$ a\\ proxy=https://proxy-prc.intel.com:911\n proxy=http://proxy-prc.intel.com:911' /etc/yum.conf
export https_proxy=https://proxy-prc.intel.com:911
export http_proxy=http://proxy-prc.intel.com:911
fi

#install dependencies
yum install gcc cmake gcc-c++ autoconf automake libtool libdrm-devel kernel-headers git expect \
redhat-lsb-core -y \

if [ $? -eq 0 ]
then
echo "Denpendency has been installed." >> install_version.log
else
echo "Denpendency has not been installed." >> install_version.log
#exit 0
fi



./installperl.sh

if [ $? -eq 0 ]
then
echo 'perl has been installed.'  >> install_version.log
else
echo 'perl has not  been installed.' >> install_version.log
#exit $?
fi

./third_party_tool.sh
if [ $? -eq 0 ]
then
echo 'third_party_tool has been installed.'  >> install_version.log
else
echo 'third_party_tool has not  been installed.' >> install_version.log
fi

#prepare test_system
if [ ! -d /home/media/ws/msdk_validation/test_system ]
then
mkdir -p /home/media/ws/msdk_validation/test_system
else
echo 'package  exist!'
rm -rf /home/media/ws/msdk_validation/test_system
mkdir -p /home/media/ws/msdk_validation/test_system

fi


unzip  `pwd`/test_system.zip -d /home/media/ws/msdk_validation/test_system
cp -raf `pwd`/6.0/ /home/media/ws/msdk_validation/test_system
ROOTPATH=/home/media/ws/msdk_validation/test_system

sed -i "48 i\ \ \  'c7.3'   => {'family' => 'linux'  }, # CentOS 7.3" $ROOTPATH/_testsuite/lib/msdk/platform.pm

if [ ! -d /home/media/ws/msdk_validation/mediasdk_streams ]
then
mkdir -p /home/media/ws/msdk_validation/mediasdk_streams
else
echo 'The package  exists!'
fi

chmod 755 -R /home/media/ws/msdk_validation/test_system
chown media:media -R /home/media/ws/
cp env.sh /home/media/ws/msdk_validation/
cp mount.sh /home/media/ws/msdk_validation/
