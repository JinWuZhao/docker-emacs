# Emacs Docker Image

## Introduction

This image is based on [Apache Alpine Linux](https://hub.docker.com/_/alpine/). The alpine image is so lite that it's size is less than 5MB. So I use this image as base.  
This image contains these primary tools (except provided by alpine):
- bash
- git
- curl
- openssh-client
- emacs
- shadowsocks-libev (The Chinese buddies will need it ^o^)
- proxychains-ng (A tool helps you use shadowsocks conveniently)

## Build

Clone this repository to your disk. Go into the directory and run this command:  
```
docker build .
```

## Usage

You can mount your local workspace to path `/root` of container. So the directory `.emacs.d` will be generated to your local workspace:  
```
docker run -it --rm -v /path/to/workspace:/root jinwuzhao/emacs
```
If you need network proxy, use `-p` option:
```
docker run -it --rm -v /path/to/workspace:/root jinwuzhao/emacs -p
```
Note this command will copy `sscfg.json` from local workspace to the path `/etc/shadowsocks/config.json` of container and copy `proxychains.conf` to `/etc/proxychains.conf`. Then launch the ss-local(shadowsocks-libev client) with config `sscfg.json` and run emacs by proxychains4(proxychains-ng) with config `proxychains.conf`.  
This repository contains `sscfg.json` and `proxychains.conf` sample. You can modify them as you need.  


