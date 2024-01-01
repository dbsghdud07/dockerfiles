#!/bin/bash
set -e 

# Get key
add-apt-repository ppa:git-core/ppa

apt-get update
apt-get upgrade -y

apt-get install -y \
	python3-pip \
	terminator \
	gedit \
	cmake \
	git \
	vim \
	tree \
	software-properties-common \
	apt-transport-https \
	wget

apt-get update
apt-get upgrade -y