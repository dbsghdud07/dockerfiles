#!/bin/bash
set -e 

apt-get update
apt-get upgrade -y

apt-get install software-properties-common

# Get key
add-apt-repository -y ppa:git-core/ppa 

apt-get update
apt-get upgrade -y

apt-get install -y --allow-unauthenticated \
	python3-pip \
	terminator \
	gedit \
	cmake \
	git \
	vim \
	tree \
	software-properties-common \
	apt-transport-https \
	wget \
	curl

apt-get update
apt-get upgrade -y