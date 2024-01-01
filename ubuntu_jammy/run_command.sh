docker run -it \
    --privileged \
    -e DISPLAY=$DISPLAY \
    --env="QT_X11_NO_MITSHM=1" \
    -v="/tmp/.gazebo/:/root/.gazebo/" \
    -v /tmp/.X11-unix:/tmp/.X11-unix:ro \
    -v /home/hy/docker_mounted/humble_1/:/root/mounted_folder/ \
    --hostname hy-B660M-HD3P \
    --network host \
    --gpus all \
    --name humble_1.0 \
    humble:v1.0 bash