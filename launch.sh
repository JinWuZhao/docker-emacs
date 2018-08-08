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

# setup user
NAME=`whoami`
MY_UID=`ls -nd /mnt/share/Documents | awk '{print $3}'`
if [ "$MY_UID" != `id -u` ];
then
    NAME='me'
    adduser -s /bin/bash -u $MY_UID -D $NAME
    passwd -u -d $NAME > /dev/null
    echo "$NAME ALL=(ALL) ALL" >> /etc/sudoers
fi
unset MY_UID
su -c 'ln -s /mnt/share/Documents ~/' $NAME
su -c 'ln -s /mnt/share/Download ~/' $NAME

# setup shadowsocks
SSCFG=/mnt/share/Download/sscfg.json

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
PCSCFG=/mnt/share/Download/proxychains.conf

if [ -f "$PCSCFG" ]
then
    cp -f $PCSCFG /etc/proxychains.conf
fi

unset PCSCFG

if test $[USEPROXY] -eq 0
then
    unset USEPROXY
    su -c 'proxychains4 -q emacs ~/Documents' $NAME
    kill `pgrep ss-local`
else
    unset USEPROXY
    su -c 'emacs ~/Documents' $NAME
fi
