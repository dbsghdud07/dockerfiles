docker build -t open3d:v1.0 .

docker run -it \
    --privileged \
    -e DISPLAY=$DISPLAY \
    --env="QT_X11_NO_MITSHM=1" \
    -v /tmp/.X11-unix:/tmp/.X11-unix:ro \
    -v /home/hy/docker_mounted/:/root/mounted_folder/ \
    --hostname hy \
    --network host \
    --gpus all \
    --ipc=host \
    --name open3d \
    open3d:v1.0