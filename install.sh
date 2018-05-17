#!/bin/sh

apk update
apk upgrade

apk --no-cache add tzdata
apk --no-cache add bash
apk --no-cache add git
apk --no-cache add curl
apk --no-cache add emacs
apk --no-cache add openssh-client
apk --no-cache add file
apk --no-cache add gcc
apk --no-cache add make
apk --no-cache add musl-dev
apk --no-cache add the_silver_searcher
apk --no-cache add ca-certificates

echo "http://dl-cdn.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories
apk update
apk --no-cache add libressl2.7-libcrypto

echo "http://dl-cdn.alpinelinux.org/alpine/v3.7/main" > /etc/apk/repositories
echo "http://dl-cdn.alpinelinux.org/alpine/v3.7/community" >> /etc/apk/repositories
apk update
apk --no-cache add libev
apk --no-cache add libsodium
apk --no-cache add pcre
apk --no-cache add udns

echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories
apk update
apk --no-cache add shadowsocks-libev

echo "http://dl-cdn.alpinelinux.org/alpine/v3.7/main" > /etc/apk/repositories
echo "http://dl-cdn.alpinelinux.org/alpine/v3.7/community" >> /etc/apk/repositories
apk update

cd /mnt
wget -c https://github.com/rofl0r/proxychains-ng/releases/download/v4.12/proxychains-ng-4.12.tar.xz
tar -xf proxychains-ng-4.12.tar.xz
rm -rf proxychains-ng-4.12.tar.xz
cd proxychains-ng-4.12
./configure --prefix=/usr --sysconfdir=/etc
make
make install
make install-config
cd ..
rm -rf proxychains-ng-4.12

apk del gcc --purge
apk del make --purge
apk del musl-dev --purge

