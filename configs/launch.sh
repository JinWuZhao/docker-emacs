#!/bin/bash

echo "running launch.sh $@"

# copy home files
HOMEDIR=/mnt/share/configs/homedir

if [ -d "$HOMEDIR" ];
then
    cp -rfT $HOMEDIR ~
fi

if [ $1 == '-p' ];
then
    sslocal -c /etc/shadowsocks/config.json &
    proxychains4 -q emacs .
    kill `pgrep sslocal`
else
    emacs .
fi
