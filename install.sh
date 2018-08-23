#!/bin/sh

apk update
apk upgrade

apk --no-cache add sudo
apk --no-cache add busybox-suid
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
apk --no-cache add libressl2.7-libcrypto
apk --no-cache add libev
apk --no-cache add libsodium
apk --no-cache add pcre
apk --no-cache add udns
apk --no-cache add rust
apk --no-cache add cargo
apk --no-cache add diffutils
apk --no-cache add ca-certificates

echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories
apk update
apk --no-cache add shadowsocks-libev

echo "http://dl-cdn.alpinelinux.org/alpine/v3.8/main" > /etc/apk/repositories
echo "http://dl-cdn.alpinelinux.org/alpine/v3.8/community" >> /etc/apk/repositories
apk update

cd /mnt
git clone https://github.com/rofl0r/proxychains-ng.git
cd proxychains-ng
git checkout v4.13
./configure --prefix=/usr --sysconfdir=/etc
make
make install
make install-config
cd ..
rm -rf proxychains-ng

cd /mnt
git clone https://github.com/BurntSushi/ripgrep
cd ripgrep
cargo build --release
mv ./target/release/rg /usr/bin/
cd ..
rm -rf ripgrep

apk del cargo --purge
apk del rust --purge
rm -rf ~/.cargo
