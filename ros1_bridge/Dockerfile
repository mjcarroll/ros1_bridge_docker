ARG FROM_IMAGE=ros2:source
FROM $FROM_IMAGE

RUN apt-get update && apt install -y \
    ros-core-dev


ENV ROS2_WS /opt/ros1_bridge
RUN mkdir -p $ROS2_WS/src
WORKDIR $ROS2_WS
RUN cd src && git clone https://github.com/ros2/ros1_bridge

RUN . /opt/ros2_ws/install/setup.sh && colcon build

