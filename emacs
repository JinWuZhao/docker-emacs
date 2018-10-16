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

if [ -d "$CONFIGS" ];
then
    docker run -it --rm -v $WORKSPACE:/mnt/share/Documents -v $CONFIGS:/mnt/share/configs jinwuzhao/emacs:archlinux $@
else
    docker run -it --rm -v $WORKSPACE:/mnt/share/Documents jinwuzhao/emacs:archlinux $@
fi

