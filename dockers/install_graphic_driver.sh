#!/bin/bash
apt-get -y update
DRIVER_NAME=`apt-cache search nvidia |grep $GDRIVER | head -n1 |cut -d" " -f1`


if [ "$DRIVER_NAME" == "" ] ; then
	add-apt-repository -y ppa:graphics-drivers/ppa
	apt update
	DRIVER_NAME=`apt search nvidia |grep $GDRIVER | head -n1 |cut -d"/" -f1`
fi
if [ "$DRIVER_NAME" == "" ] ; then
	echo "Error nvidia Driver $GDRIVER not found on guest machine" >&2
	echo "Try install the latest nvidia driver (using ppa) on your host machine" >&2
	exit -1
fi
DEBIAN_FRONTEND=noninteractive apt-get install -y $DRIVER_NAME
update-locale LANG=C LANGUAGE=C LC_ALL=C LC_MESSAGES=POSIX
echo "Installed nvidia driver version is:" $DRIVER_NAME $GDRIVER

