docker build -t isaac_sim:v5.0.0 .

docker run -it \
    --privileged \
    -e DISPLAY=$DISPLAY \
    --env="QT_X11_NO_MITSHM=1" \
    -e "PRIVACY_CONSENT=Y" \
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
    -v /home/$USER/docker_mounted/:/root/mounted_folder/ \
    -v /mnt/ssd1/:/root/ssd1/ \
    --hostname hy \
    --network host \
    --gpus all \
    --name isaac_sim_dev \
    --ipc host \
    isaac_sim:v5.0.0 /bin/bash