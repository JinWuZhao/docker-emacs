#!/bin/sh

cd $1
if test $? -ne 0
then
   exit 1
fi

WORKSPACE=`pwd`

docker run -it --rm -v $WORKSPACE:/root/Documents jinwuzhao/emacs $2
