# Isaac Sim 5.0.0 + ROS 2 Humble (clean & robust)
FROM nvcr.io/nvidia/isaac-sim:5.0.0

# ---------- NVIDIA runtime ----------
ENV NVIDIA_VISIBLE_DEVICES=${NVIDIA_VISIBLE_DEVICES:-all}
ENV NVIDIA_DRIVER_CAPABILITIES=${NVIDIA_DRIVER_CAPABILITIES:+$NVIDIA_DRIVER_CAPABILITIES,}graphics

USER root

# ---------- Timezone / locale (quiet, noninteractive) ----------
ENV DEBIAN_FRONTEND=noninteractive
RUN set -eux; \
  echo 'Etc/UTC' > /etc/timezone; \
  ln -sf /usr/share/zoneinfo/Etc/UTC /etc/localtime; \
  apt-get update -o Acquire::CompressionTypes::Order::=gz; \
  apt-get install -y --no-install-recommends tzdata locales ca-certificates gnupg lsb-release curl; \
  sed -i 's/^# *\(en_US.UTF-8 UTF-8\)/\1/' /etc/locale.gen; \
  locale-gen; \
  update-locale LANG=en_US.UTF-8; \
  rm -rf /var/lib/apt/lists/*
ENV LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8

# ---------- Basic tools ----------
RUN set -eux; \
  apt-get update -o Acquire::CompressionTypes::Order::=gz; \
  apt-get install -y --no-install-recommends \
    dirmngr git python3-pip; \
  rm -rf /var/lib/apt/lists/*

# ---------- ROS 2 Humble APT source (no keyserver) ----------
RUN set -eux; \
  install -m 0755 -d /etc/apt/keyrings; \
  curl -fsSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key \
    | gpg --dearmor -o /etc/apt/keyrings/ros-archive-keyring.gpg; \
  chmod 0644 /etc/apt/keyrings/ros-archive-keyring.gpg; \
  sh -c 'echo "deb [signed-by=/etc/apt/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" > /etc/apt/sources.list.d/ros2.list'

# ---------- Install ROS 2 Humble (default: ros-base) ----------
RUN set -eux; \
  apt-get update -o Acquire::CompressionTypes::Order::=gz; \
  apt-get install -y --no-install-recommends \
    ros-humble-ros-base \
    python3-rosdep \
    python3-colcon-common-extensions \
    python3-colcon-mixin \
    python3-vcstool \
  ; \
  rm -rf /var/lib/apt/lists/*

# --- (옵션) GUI 툴들 필요 시 주석 해제 ---
# RUN set -eux; \
#   apt-get update -o Acquire::CompressionTypes::Order::=gz; \
#   apt-get install -y --no-install-recommends \
#     software-properties-common; \
#   add-apt-repository -y universe; \
#   apt-get update -o Acquire::CompressionTypes::Order::=gz; \
#   apt-get install -y --no-install-recommends \
#     ros-humble-rviz2 \
#     ros-humble-rqt \
#     ros-humble-image-tools \
#     ros-humble-tf2-tools; \
#   rm -rf /var/lib/apt/lists/*

# ---------- rosdep (best-effort) ----------
RUN set -eux; \
  rosdep init || true; \
  rosdep update --rosdistro humble || true

# ---------- XDG runtime for GUI/Qt warnings ----------
RUN mkdir -p /tmp/runtime-root && chmod 0700 /tmp/runtime-root
ENV XDG_RUNTIME_DIR=/tmp/runtime-root

# ---------- Optional install script (if you have one) ----------
# (빌드 타이밍에 네트워크가 필요하다면 실패를 막기 위해 개별 실행을 추천)
COPY install.sh /tmp/install.sh
RUN chmod +x /tmp/install.sh && /bin/bash -lc '/tmp/install.sh' || true

# ---------- ROS 2 workspace ----------
ARG WORKSPACE=/root/ros2_ws
ENV WORKSPACE=${WORKSPACE}
WORKDIR ${WORKSPACE}
RUN mkdir -p ${WORKSPACE}/src

# ---------- Bash quality-of-life ----------
ENV ROS_DISTRO=humble \
    ROS_DOMAIN_ID=34 \
    ROS_LOCALHOST_ONLY=1
RUN printf '\n# --- ROS 2 Humble ---\n[ -f /opt/ros/humble/setup.bash ] && source /opt/ros/humble/setup.bash\n' >> /etc/bash.bashrc && \
    printf '\n# --- User ROS2 workspace ---\n[ -f ~/ros2_ws/install/local_setup.bash ] && source ~/ros2_ws/install/local_setup.bash\n' >> /etc/bash.bashrc && \
    printf '\n# --- Env ---\nexport ROS_DOMAIN_ID=34\nexport ROS_LOCALHOST_ONLY=1\n' >> /etc/bash.bashrc && \
    printf '\n# --- Aliases ---\n' >> /etc/bash.bashrc && \
    printf "alias cw='cd ~/ros2_ws'\n" >> /etc/bash.bashrc && \
    printf "alias cs='cd ~/ros2_ws/src'\n" >> /etc/bash.bashrc && \
    printf "alias cb='cd ~/ros2_ws && colcon build --symlink-install'\n" >> /etc/bash.bashrc && \
    printf "alias cbp='cd ~/ros2_ws && colcon build --symlink-install --packages-select'\n" >> /etc/bash.bashrc && \
    printf "alias sb='source ~/.bashrc'\n" >> /etc/bash.bashrc && \
    printf "alias gb='gedit ~/.bashrc'\n" >> /etc/bash.bashrc && \
    printf "alias rt=\"ros2 topic list\"\n" >> /etc/bash.bashrc && \
    printf "alias re=\"ros2 topic echo\"\n" >> /etc/bash.bashrc && \
    printf "alias rn=\"ros2 node list\"\n" >> /etc/bash.bashrc && \
    printf "alias testpub='ros2 run demo_nodes_cpp talker'\n" >> /etc/bash.bashrc && \
    printf "alias testsub='ros2 run demo_nodes_cpp listener'\n" >> /etc/bash.bashrc

# ---------- Keep container idle by default ----------
ENTRYPOINT []
CMD ["bash", "-lc", "sleep infinity"]
