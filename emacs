#!/bin/sh

cd $1
if test $? -ne 0
then
   exit 1
fi

WORKSPACE=`pwd`
DOWNLOAD='' # some of your useful files

if [ -d "$DOWNLOAD" ];
then
    docker run -it --rm -v $WORKSPACE:/mnt/share/Documents -v $DOWNLOAD:/mnt/share/Download jinwuzhao/emacs $2
else
    docker run -it --rm -v $WORKSPACE:/mnt/share/Documents jinwuzhao/emacs $2
fi

