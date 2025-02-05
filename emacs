#!/bin/sh

CONFIGS='' # mount some of your useful scripts. eg: -v /path/to/configs:/mnt/share/configs

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

X11CFGS=''
if [ "$DISPLAY" != '' ] && [ -d "/tmp/.X11-unix" ];
then
    xhost +
    X11CFGS="-e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix"
fi

docker run -it --rm $X11CFGS $CONFIGS -v $WORKSPACE:/mnt/share/Documents jinwuzhao/emacs $@

