docker build -t issac_sim:v1.0 .

docker run -it \
    --privileged \
    -e DISPLAY=$DISPLAY \
    --env="QT_X11_NO_MITSHM=1" \
    -e "PRIVACY_CONSENT=Y" \
    --entrypoint bash \
    -e "ACCEPT_EULA=Y" \
    -v ~/docker/isaac-sim/cache/kit:/isaac-sim/kit/cache:rw \
    -v ~/docker/isaac-sim/cache/ov:/root/.cache/ov:rw \
    -v ~/docker/isaac-sim/cache/pip:/root/.cache/pip:rw \
    -v ~/docker/isaac-sim/cache/glcache:/root/.cache/nvidia/GLCache:rw \
    -v ~/docker/isaac-sim/cache/computecache:/root/.nv/ComputeCache:rw \
    -v ~/docker/isaac-sim/logs:/root/.nvidia-omniverse/logs:rw \
    -v ~/docker/isaac-sim/data:/root/.local/share/ov/data:rw \
    -v ~/docker/isaac-sim/documents:/root/Documents:rw \
    -v /tmp/.X11-unix:/tmp/.X11-unix:ro \
    -v /home/hy/docker_mounted/issac_sim/:/root/mounted_folder/ \
    --hostname hy-B660M-HD3P \
    --network host \
    --gpus all \
    --name issac_sim \
    issac_sim:v1.0