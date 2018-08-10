# Emacs Docker Image

[![Build Status](https://travis-ci.org/JinWuZhao/docker-emacs.svg?branch=master)](https://travis-ci.org/JinWuZhao/docker-emacs)

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

You need to mount your local workspace to path `/mnt/share/Documents` of container:  
```
docker run -it --rm -v /path/to/workspace:/mnt/share/Documents jinwuzhao/emacs
```
If you need network proxy, use `-p` option:
```
docker run -it --rm -v /path/to/workspace:/mnt/share/Documents -v /path/to/config:/mnt/share/configs jinwuzhao/emacs -p
```
Note this command will copy `sscfg.json` from local config directory to the path `/etc/shadowsocks/config.json` of container and copy `proxychains.conf` to `/etc/proxychains.conf`. Then launch the ss-local(shadowsocks-libev client) with config `sscfg.json` and run emacs by proxychains4(proxychains-ng) with config `proxychains.conf`.  
This repository contains `sscfg.json` and `proxychains.conf` sample. You can modify them as you need.  
By default, the `detach-keys` of docker is `ctrl+p,ctrl+q` and it will conflicts with the move key of emacs. To solve this problem, you can modify the `detach-keys` to another value such as `ctrl+@,ctrl+q` before you create the container:  
```
docker run -it --detach-keys 'ctrl-@,ctrl-q' --rm -v /path/to/workspace:/mnt/share/Documents jinwuzhao/emacs
``` 
Alternatively youd can modify the docker config file at `~/.docker/config.json`:  
```
{
	"auths": {},
	"HttpHeaders": {
		"User-Agent": ""
	},
	"detachKeys": "ctrl-@,ctrl-q"
}
```
