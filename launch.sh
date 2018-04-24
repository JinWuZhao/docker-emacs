#!/bin/bash

`test "$1" = '-p'`
USEPROXY=$?

# setup timezone
TZFILE=/usr/share/zoneinfo/$TIMEZONE

if [ -f "$TZFILE" ]
then
    cp -f $TZFILE /etc/localtime
    echo $TIMEZONE > /etc/timezone
fi

unset TIMEZONE
unset TZFILE

# setup shadowsocks
SSCFG=/root/Documents/sscfg.json

if [ -f "$SSCFG" ]
then
    mkdir -p /etc/shadowsocks
    cp -f $SSCFG /etc/shadowsocks/config.json
fi

if test $[USEPROXY] -eq 0
then
    ss-local -c /etc/shadowsocks/config.json &
fi

unset SSCFG

# setup proxychains
PCSCFG=/root/Documents/proxychains.conf

if [ -f "$PCSCFG" ]
then
    cp -f $PCSCFG /etc/proxychains.conf
fi

unset PCSCFG

if test $[USEPROXY] -eq 0
then
    unset USEPROXY
    proxychains4 -q emacs /root/Documents
    kill `pgrep ss-local`
else
    unset USEPROXY
    emacs /root/Documents
fi
