docker run -it \
    --privileged \
    -e DISPLAY=$DISPLAY \
    --env="QT_X11_NO_MITSHM=1" \
    -v="/tmp/.gazebo/:/root/.gazebo/" \
    -v /tmp/.X11-unix:/tmp/.X11-unix:ro \
    -v /home/hy/docker_mounted/kimm_orchard/:/root/mounted_folder/ \
    --hostname hy-B660M-HD3P \
    --network host \
    --gpus all \
    --name kimm_orchard \
    kimm:v1.0 bash