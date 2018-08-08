#!/bin/bash

USEPROXY=$1

# setup timezone
TZFILE=/usr/share/zoneinfo/$TIMEZONE

if [ -f "$TZFILE" ];
then
    cp -f $TZFILE /etc/localtime
    echo $TIMEZONE > /etc/timezone
fi

unset TIMEZONE
unset TZFILE

# setup user
NAME=root
MY_UID=`ls -nd /mnt/share/Documents | awk '{print $3}'`
if [ "$MY_UID" != `id -u` ];
then
    NAME='me'
    adduser -s /bin/bash -u $MY_UID -D $NAME
    passwd -u -d $NAME >/dev/null 2>&1
    echo "$NAME ALL=(ALL) ALL" >> /etc/sudoers
    if [ -f "/root/.emacs" ];
    then
        cp -f /root/.emacs /home/$NAME/
    fi
    if [ -f "/root/.emacs.d" ];
    then
        cp -rf /root/.emacs.d /home/$NAME/
    fi
    chown -R "$NAME:$NAME" /home/$NAME
fi
unset MY_UID
su -c 'ln -s /mnt/share/Documents ~/' $NAME
su -c 'ln -s /mnt/share/Download ~/' $NAME

# setup shadowsocks
SSCFG=/mnt/share/Download/sscfg.json

if [ -f "$SSCFG" ];
then
    mkdir -p /etc/shadowsocks
    cp -f $SSCFG /etc/shadowsocks/config.json
fi

if [ "$USEPROXY" == '-p' ];
then
    ss-local -c /etc/shadowsocks/config.json &
fi

unset SSCFG

# setup proxychains
PCSCFG=/mnt/share/Download/proxychains.conf

if [ -f "$PCSCFG" ];
then
    cp -f $PCSCFG /etc/proxychains.conf
fi

unset PCSCFG

if [ "$USEPROXY" == '-p' ];
then
    unset USEPROXY
    su -c 'proxychains4 -q emacs ~/Documents' $NAME
    kill `pgrep ss-local`
else
    unset USEPROXY
    su -c 'emacs ~/Documents' $NAME
fi
