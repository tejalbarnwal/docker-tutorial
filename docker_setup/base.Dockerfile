# Ubuntu 18.04 with nvidia-docker2 beta opengl support
FROM nvidia/opengl:1.0-glvnd-devel-ubuntu18.04

# Tools I find useful during development
RUN apt-get update -qq \
 && apt-get install -y -qq \
        build-essential \
        bwm-ng \
        cmake \
        cppcheck \
        gdb \
        git \
        g++-8 \
        libbluetooth-dev \
        libccd-dev \
        libcwiid-dev \
        libfcl-dev \
        libgoogle-glog-dev \
        libspnav-dev \
        libusb-dev \
        lsb-release \
        python3-dbg \
        python3-empy \
        python3-numpy \
        python3-setuptools \
        python3-pip \
        python3-venv \
        ruby2.5 \
        ruby2.5-dev \
        software-properties-common \
        sudo \
        vim \
        wget \
        net-tools \
        iputils-ping \
        libyaml-cpp-dev \
        curl \
        zsh \
        tmux \
        language-pack-en \
   &&   update-locale \
   &&   apt-get clean -qq

# Add a user with the same user_id as the user outside the container
# Requires a docker build argument `user_id`
ARG user_id=1000
ENV USERNAME tejal
RUN useradd -U --uid ${user_id} -ms /bin/bash $USERNAME \
 && echo "$USERNAME:$USERNAME" | chpasswd \
 && adduser $USERNAME sudo \
 && echo "$USERNAME ALL=NOPASSWD: ALL" >> /etc/sudoers.d/$USERNAME

# Commands below run as the developer user
USER $USERNAME

# When running a container start in the developer's home folder
WORKDIR /home/$USERNAME

RUN export DEBIAN_FRONTEND=noninteractive \
 && sudo apt-get update -qq \
 && sudo -E apt-get install -y -qq \
    tzdata \
 && sudo ln -fs /usr/share/zoneinfo/America/Los_Angeles /etc/localtime \
 && sudo dpkg-reconfigure --frontend noninteractive tzdata \
 && sudo apt-get clean -qq

# reference: trunc8
# run the installation script  
RUN wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true
# it continues to remain in zsh in future images
SHELL ["/bin/zsh", "-c"]
# zsh plugins
RUN git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions \
&& git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting


CMD ["zsh"]

# install ROS and required packages
RUN sudo /bin/sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list' \
 && sudo /bin/sh -c 'curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -' \
 && sudo apt-get update -qq \
 && sudo apt-get install -y -qq \
    libpcl-dev \
    libpcl-conversions-dev \
    python-catkin-tools \
    python-rosdep \
    python-rosinstall \
    ros-melodic-desktop-full \
 && sudo rosdep init \
 && sudo apt-get clean -qq

RUN rosdep update
RUN /bin/zsh -c 'source /opt/ros/melodic/setup.zsh'

# Clone all the subt models so that you don't download them every time
# docker is run
# RUN mkdir -p subt_ws/src \
#  && cd subt_ws/src \
#  && git clone https://github.com/trunc8/Ball_Tracking_Using_OpenCV_And_ROS.git ball_tracking

# WORKDIR /home/$USERNAME/subt_ws

# # Install Rotors
# # RUN wget https://s3.amazonaws.com/osrf-distributions/subt_robot_examples/releases/subt_robot_examples_latest.tgz
# # RUN tar xvf subt_robot_examples_latest.tgz

# # build the subt tech repo (set gcc to version 8 first)
# RUN sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-8 800 --slave /usr/bin/g++ g++ /usr/bin/g++-8 --slave /usr/bin/gcov gcov /usr/bin/gcov-8
# RUN /bin/bash -c 'source /opt/ros/melodic/setup.bash && catkin_make -DCMAKE_BUILD_TYPE=Release install'

# RUN /bin/sh -c 'echo ". /opt/ros/melodic/setup.bash" >> ~/.bashrc' \
#  && /bin/sh -c 'echo ". ~/subt_ws/install/setup.sh" >> ~/.bashrc'

# Customize your image here.
# E.g.:
# ENV PATH="/opt/sublime_text:$PATH"