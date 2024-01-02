docker build -t cuda10.1_cudnn7_ubuntu16.04_py3.7:v1.0 .

docker run -it \
    --privileged \
    -e DISPLAY=$DISPLAY \
    --env="QT_X11_NO_MITSHM=1" \
    -v /tmp/.X11-unix:/tmp/.X11-unix:ro \
    -v /home/hy/docker_mounted/cuda10.1/:/root/mounted_folder/ \
    --hostname hy-B660M-HD3P \
    --network host \
    --gpus all \
    --name cuda10.1 \
    cuda10.1_cudnn7_ubuntu16.04_py3.7:v1.0 bash