#!/bin/bash

#test_system package
if [ ! -d /home/media/ws/msdk_validation/test_system ]
then
mkdir -p /home/media/ws/msdk_validation/test_system
else
echo "package  exist!"
rm -rf /home/media/ws/msdk_validation/test_system
mkdir -p /home/media/ws/msdk_validation/test_system

fi


unzip `pwd`/test_system.zip -d /home/media/ws/msdk_validation/test_system
cp -raf `pwd`/6.0/ /home/media/ws/msdk_validation/test_system
ROOTPATH=/home/media/ws/msdk_validation/test_system

sed -i "48 i\ \ \  'c7.3'   => {'family' => 'linux'  }, # CentOS 7.3" $ROOTPATH/_testsuite/lib/msdk/platform.pm

if [ ! -d /home/media/ws/msdk_validation/mediasdk_streams ]
then
mkdir -p /home/media/ws/msdk_validation/mediasdk_streams
else
echo 'The package  exists!'
fi

