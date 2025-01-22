#!/bin/sh

if [ $# -gt 0 ];
then
    WORKDIR=`echo $@ | awk '{print $NF}'`
    cd $WORKDIR
    if [ $? != 0 ];
    then
	exit 1
    fi
else
    echo "need a parameter of directory path at least"
    exit 1
fi

WORKSPACE=`pwd`
CONFIGS='' # some of your useful files
X11CFGS=''
if [ "$DISPLAY" != '' ] && [ -d "/tmp/.X11-unix" ];
then
    xhost +
    X11CFGS="-e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix"
fi

if [ -d "$CONFIGS" ];
then
    docker run -it --rm $X11CFGS -v $WORKSPACE:/mnt/share/Documents -v $CONFIGS:/mnt/share/configs jinwuzhao/emacs $@
else
    docker run -it --rm $X11CFGS -v $WORKSPACE:/mnt/share/Documents jinwuzhao/emacs $@
fi

