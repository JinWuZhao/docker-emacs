#!/bin/bash

if [ $1 == '-p' ];
then
    ss-local -c /etc/shadowsocks/config.json &
    proxychains4 -q emacs .
    kill `pgrep ss-local`
else
    emacs .
fi
