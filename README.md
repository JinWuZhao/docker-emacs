# Emacs Docker Image

[![Build Status](https://travis-ci.org/JinWuZhao/docker-emacs.svg?branch=master)](https://travis-ci.org/JinWuZhao/docker-emacs) ![GitHub release](https://img.shields.io/github/tag/JinWuZhao/docker-emacs.svg)  

## Introduction

This image is based on [Archlinux](https://hub.docker.com/_/archlinux/).  
This image contains these primary tools (except provided by alpine):
- bash
- git
- curl
- openssh-client
- python
- yay (For Arch User Repository)
- gcc
- make
- emacs
- shadowsocks-rust (Used for proxy)
- proxychains-ng (A tool helps you use shadowsocks conveniently)
- other optional tools

## Build

Clone this repository to your disk. Go into the directory and run this command:  
```
docker build -t jinwuzhao/emacs .
```

## Usage

Copy shell script `emacs` from this repository to one of directories in environment variable `$PATH`.  
Run command `emacs .` to open project with current directory. You can also use other relative path or absolute path instead.  
If you need network proxy, use `-p` option:  
```
emacs . -p
```
Note this command will copy `sscfg.json` from local config directory to the path `/etc/shadowsocks/config.json` of container and copy `proxychains.conf` to `/etc/proxychains.conf`. Then launch the ss-local(shadowsocks-libev client) with config `sscfg.json` and run emacs by proxychains4(proxychains-ng) with config `proxychains.conf`.  
This repository contains `sscfg.json` and `proxychains.conf` sample. You can modify them as you need.  
By default, the `detach-keys` of docker is `ctrl+p,ctrl+q` and it will conflicts with the move key of emacs. To solve this problem, you can modify the `detach-keys` to another value such as `ctrl+^,ctrl+q`.You can modify the docker config file at `~/.docker/config.json`:  
```
{
	"detachKeys": "ctrl-^,ctrl-q"
}
```
If you run it with X11 environment and want to share clipboards between host and container, you can install emacs package `xclip.el`:  
```
# install xclip.el
M-x package-install RET xclip
M-x xclip-mode
```
You may add `xclip-mode` into `.emacs` file and commit a layer on this image.
