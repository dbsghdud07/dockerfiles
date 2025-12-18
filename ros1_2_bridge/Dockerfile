FROM althack/ros2:foxy-cuda-full-2023-06-30

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update && apt-get install -y \
    lsb-release \
    gnupg2 \
    curl

RUN curl -sSL "http://packages.ros.org/ros.key" | apt-key add -

RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu focal main" > /etc/apt/sources.list.d/ros1-latest.list'

RUN apt-get update && apt-get install -y \
    ros-noetic-desktop-full \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y \
    ros-foxy-ros1-bridge \
    && rm -rf /var/lib/apt/lists/*

RUN echo "\n\
source /opt/ros/foxy/setup.bash \n\
source /opt/ros/noetic/setup.bash \n\
echo 'ROS2 Foxy + ROS1 Noetic environment set' \n\
" >> /root/.bashrc

RUN apt-get update && apt-get install -y \
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
    && rm -rf /var/lib/apt/lists/*