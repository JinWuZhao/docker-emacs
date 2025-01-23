#!/bin/sh

echo "LC_ALL=en_US.UTF-8" >> /etc/environment
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf
locale-gen en_US.UTF-8

rm -fr /etc/pacman.d/gnupg
pacman-key --init
pacman-key --populate archlinux

pacman -Syu --disable-sandbox --noconfirm

pacman -S --disable-sandbox --noconfirm tzdata
pacman -S --disable-sandbox --noconfirm sudo
pacman -S --disable-sandbox --noconfirm git
pacman -S --disable-sandbox --noconfirm python
pacman -S --disable-sandbox --noconfirm python-pip
pacman -S --disable-sandbox --noconfirm --needed base-devel
useradd yay -s /bin/bash -u 50000 -m && passwd -u -d yay >/dev/null 2>&1 && echo 'yay ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers && su yay -s /bin/bash -c 'mkdir -p /tmp/yay-bin && git clone --depth=1 https://aur.archlinux.org/yay-bin.git /tmp/yay-bin && cd /tmp/yay-bin/ && makepkg -si --noconfirm'
pacman -S --disable-sandbox --noconfirm emacs
pacman -S --disable-sandbox --noconfirm awk
pacman -S --disable-sandbox --noconfirm less
pacman -S --disable-sandbox --noconfirm openssh
pacman -S --disable-sandbox --noconfirm file
pacman -S --disable-sandbox --noconfirm gcc
pacman -S --disable-sandbox --noconfirm make
pacman -S --disable-sandbox --noconfirm the_silver_searcher
pacman -S --disable-sandbox --noconfirm ca-certificates
pacman -S --disable-sandbox --noconfirm diffutils
pacman -S --disable-sandbox --noconfirm shadowsocks-rust
pacman -S --disable-sandbox --noconfirm ripgrep
pacman -S --disable-sandbox --noconfirm proxychains-ng
pacman -S --disable-sandbox --noconfirm xclip
pacman -S --disable-sandbox --noconfirm ttf-dejavu
pacman -S --disable-sandbox --noconfirm adobe-source-han-sans-cn-fonts
pacman -S --disable-sandbox --noconfirm adobe-source-han-sans-tw-fonts

pacman -Scc --disable-sandbox --noconfirm
