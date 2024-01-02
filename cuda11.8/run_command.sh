docker build -t cuda11.8_ubuntu22.04_cudnn8:v1.0 .

docker run -it \
    --privileged \
    -e DISPLAY=$DISPLAY \
    --env="QT_X11_NO_MITSHM=1" \
    -v /tmp/.X11-unix:/tmp/.X11-unix:ro \
    -v /home/hy/docker_mounted/cuda11.8/:/root/mounted_folder/ \
    --hostname hy-B660M-HD3P \
    --network host \
    --gpus all \
    --name cuda11.8 \
    cuda11.8_ubuntu22.04:v1.0 bash