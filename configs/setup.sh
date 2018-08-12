#!/bin/bash

echo "running setup.sh"

# setup shadowsocks
SSCFG=./sscfg.json

if [ -f "$SSCFG" ];
then
    mkdir -p /etc/shadowsocks
    cp -f $SSCFG /etc/shadowsocks/config.json
fi

# setup proxychains
PCSCFG=./proxychains.conf

if [ -f "$PCSCFG" ];
then
    cp -f $PCSCFG /etc/proxychains.conf
fi
