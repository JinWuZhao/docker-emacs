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
MY_UID=`ls -nd /home/share | awk '{print $3}'`
NAME='me'
adduser -s /bin/bash -u $MY_UID -D $NAME
passwd -u -d $NAME
echo "$NAME ALL=(ALL) ALL" >> /etc/sudoers
unset MY_UID

# setup shadowsocks
SSCFG=/root/Download/sscfg.json

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
PCSCFG=/root/Download/proxychains.conf

if [ -f "$PCSCFG" ]
then
    cp -f $PCSCFG /etc/proxychains.conf
fi

unset PCSCFG

if test $[USEPROXY] -eq 0
then
    unset USEPROXY
    su -c 'proxychains4 -q emacs /root/Documents' $NAME
    kill `pgrep ss-local`
else
    unset USEPROXY
    su -c 'emacs /root/Documents' $NAME
fi
