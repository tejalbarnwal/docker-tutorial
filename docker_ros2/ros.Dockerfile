FROM rd-base

# ensure support for UTF-8
RUN sudo apt update 
RUN sudo apt install locales
RUN sudo locale-gen en_US en_US.UTF-8
RUN sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
RUN export LANG=en_US.UTF-8


# set spurces
RUN sudo apt install software-properties-common
RUN sudo add-apt-repository universe

# add ros2 gpg key
RUN sudo apt update && sudo apt install curl -y
RUN sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg

# add repo to the sources list
RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null

# update packages
RUN sudo apt update

# ROS2 rquires usto select keyboard-configuration according to country/region we are located in
# doing debian non interactive eleminates its condition to require input and its defaults to the normal configuration
RUN sudo DEBIAN_FRONTEND=noninteractive apt-get install -y keyboard-configuration

# install ros2 with deskptop versiomn
RUN sudo apt install -y ros-foxy-desktop python3-argcomplete

# # source the environment with zsh
RUN /bin/zsh -c 'source /opt/ros/foxy/setup.zsh'

