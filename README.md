
An example of building `ros1_bridge` on Ubuntu 22.04 `jammy` on top of a ROS 2 `humble` source install.


This consists of three containers in layers, because I cribbed from osrf/docker_images: https://github.com/osrf/docker_images/tree/master/ros2/source


In order for this to work, you have to skip installing anything from the ros package mirror.

Outline of the steps I followed (and what is in docker) below

```
sudo apt-get update

# Install core apt dependencies
apt-get install -q -y --no-install-recommends \
    bash-completion \
    build-essential \
    cmake \
    dirmngr \
    git \
    git \
    gnupg2 \
    libssl-dev \
    python3-flake8 \
    python3-flake8-blind-except \
    python3-flake8-builtins \
    python3-flake8-class-newline \
    python3-flake8-comprehensions \
    python3-flake8-deprecated \
    python3-flake8-docstrings \
    python3-flake8-import-order \
    python3-flake8-quotes \
    python3-pip \
    python3-pytest-repeat \
    python3-pytest-rerunfailures \
    python3-setuptools \
    wget

# Install core pip dependencies
pip3 install -U \
    argcomplete \
    colcon-common-extensions \
    colcon-mixin \
    rosdep \
    vcstool

# Initialize rosdep
sudo rosdep init
rosdep update

# Set up repositories
mkdir -p ~/ros2_ws/src
git clone https://github.com/ros2/ros2.git
vcs import src < ros2/ros2.repos

# Install dependencies
rosdep install -y \
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
    urdfdom_headers"

# Build ROS2 ws
colcon build --symlink-install

# Install ROS1 from Ubuntu package mirros
sudo apt-get install -y ros-core-dev

# Set up ros1 bridge sources
mkdir -p ~/ros1_bridge/src
cd ~/ros1_bridge/src
git clone https://github.com/ros2/ros1_bridge


# Build ROS 1 bridge
source ~/ros2_ws/install/setup.sh
colcon build
```
