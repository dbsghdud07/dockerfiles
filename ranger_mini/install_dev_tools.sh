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

apt-key adv --keyserver keyserver.ubuntu.com --recv-key F6E65AC044F831AC80A06380C8B3A55A6F3EFCDE || apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-key F6E65AC044F831AC80A06380C8B3A55A6F3EFCDE
add-apt-repository "deb https://librealsense.intel.com/Debian/apt-repo $(lsb_release -cs) main" -u

apt-key adv --keyserver keys.gnupg.net --recv-key C8B3A55A6F3EFCDE || apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-key C8B3A55A6F3EFCDE 
add-apt-repository "deb http://realsense-hw-public.s3.amazonaws.com/Debian/apt-repo xenial main" -u 

apt-get update
apt-get upgrade

apt-get install -y --allow-unauthenticated \
	ros-$ROS_DISTRO-diagnostic-updater \
	ros-$ROS_DISTRO-ros2-control \
	ros-$ROS_DISTRO-pcl-ros \
	ros-$ROS_DISTRO-tf2-eigen \
	ros-$ROS_DISTRO-rviz2 \
	librealsense2-dev \
	librealsense2-utils \
	libssl-dev \
	libusb-1.0-0-dev \
	libudev-dev \
	pkg-config \
	libgtk-3-dev \
	librealsense2-dkms \
	librealsense2-utils \
	librealsense2-dev \
	librealsense2-dbg \
	build-essential \
	libeigen3-dev \
	libjsoncpp-dev \
	libspdlog-dev \
	libcurl4-openssl-dev \
	cmake \
	python3-colcon-common-extensions