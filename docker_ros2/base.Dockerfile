# Ubuntu 20.04 with nvidia-docker with opengl support
FROM nvidia/opengl:1.0-glvnd-devel-ubuntu20.04

# ENV DEBIAN_FRONTEND noninteractive

# update apt pkgs
RUN apt-get update

# install some tools that would be commonly used
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y -qq \
        build-essential \
        bwm-ng \
        cmake \
        cppcheck \
        gdb \
        git \
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
        language-pack-en

# update system Locale
RUN update-locale

# clean the cache memory
RUN apt-get clean -qq

# Add a user with the same user_id as the user outside the container
# Requires a docker build argument `user_id`
ARG user_id=1000
ENV USERNAME tejal
RUN useradd -U --uid ${user_id} -ms /bin/bash $USERNAME \
 && echo "$USERNAME:$USERNAME" | chpasswd \
 && adduser $USERNAME sudo \
 && echo "$USERNAME ALL=NOPASSWD: ALL" >> /etc/sudoers.d/$USERNAME

# # Commands below run as the developer user
USER $USERNAME

# # When running a container start in the developer's home folder
WORKDIR /home/$USERNAME

# we update time-zone data
RUN export DEBIAN_FRONTEND=noninteractive \
 && sudo apt-get update -qq \
 && sudo -E apt-get install -y -qq \
    tzdata \
 && sudo ln -fs /usr/share/zoneinfo/Asia/Kolkata /etc/localtime \
 && sudo dpkg-reconfigure --frontend noninteractive tzdata \
 && sudo apt-get clean -qq

# the above script was created in reference to ____<adding it later>
#---------------------------------------------------------------------------------------------------------

# # run the oh-my-zsh installation script  
RUN wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true
# # it continues to remain in zsh in future images
SHELL ["/bin/zsh", "-c"]

CMD ["zsh"]

ENV NVIDIA_VISIBLE_DEVICES \
    ${NVIDIA_VISIBLE_DEVICES:-all}
ENV NVIDIA_DRIVER_CAPABILITIES \
    ${NVIDIA_DRIVER_CAPABILITIES:+$NVIDIA_DRIVER_CAPABILITIES,}graphics