#!/bin/sh

pacman -Syu --noconfirm

pacman -S --noconfirm tzdata
pacman -S --noconfirm sudo
pacman -S --noconfirm git
pacman -S --noconfirm emacs
pacman -S --noconfirm awk
pacman -S --noconfirm openssh
pacman -S --noconfirm file
pacman -S --noconfirm gcc
pacman -S --noconfirm make
pacman -S --noconfirm the_silver_searcher
pacman -S --noconfirm ca-certificates
pacman -S --noconfirm diffutils
pacman -S --noconfirm shadowsocks-libev
pacman -S --noconfirm ripgrep
pacman -S --noconfirm proxychains-ng
pacman -S --noconfirm xclip
pacman -S --noconfirm ttf-dejavu
pacman -S --noconfirm adobe-source-han-sans-cn-fonts
pacman -S --noconfirm adobe-source-han-sans-tw-fonts

pacman -Scc --noconfirm
