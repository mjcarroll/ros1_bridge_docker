ARG FROM_IMAGE=ros2:devel
FROM $FROM_IMAGE

# set environment
ARG ROS_DISTRO=humble
ENV ROS_DISTRO=$ROS_DISTRO
ENV ROS_VERSION=2 \
    ROS_PYTHON_VERSION=3
# clone source

ARG ROS2_BRANCH=$ROS_DISTRO
ARG ROS2_REPO=https://github.com/ros2/ros2.git
RUN git clone $ROS2_REPO -b $ROS2_BRANCH \
    && vcs import src < ros2/ros2.repos

# install dependencies
RUN apt-get update && rosdep install -y \
    --from-paths src \
    --ignore-src \
    --skip-keys " \
        fastcdr \
        ignition-cmake2 \
        ignition-math6 \
        python3-catkin-pkg-modules \
        python3-rosdistro-modules \
        python3-vcstool \ 
        rti-connext-dds-6.0.1 \
        urdfdom_headers" \
    && rm -rf /var/lib/apt/lists/*

# build source
RUN colcon \
    build \
    --symlink-install \
    --mixin build-testing-on release \
    --cmake-args --no-warn-unused-cli

