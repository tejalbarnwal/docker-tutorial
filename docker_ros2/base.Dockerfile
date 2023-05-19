# Ubuntu 18.04 with nvidia-docker2 beta opengl support
FROM nvidia/opengl:1.0-glvnd-devel-ubuntu20.04

# ENV TZ=Asia/Kolkata \
#     DEBIAN_FRONTEND=noninteractive

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update

RUN apt-get install -y -qq \
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

RUN update-locale

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

RUN export DEBIAN_FRONTEND=noninteractive \
 && sudo apt-get update -qq \
 && sudo -E apt-get install -y -qq \
    tzdata \
 && sudo ln -fs /usr/share/zoneinfo/Asia/Kolkata /etc/localtime \
 && sudo dpkg-reconfigure --frontend noninteractive tzdata \
 && sudo apt-get clean -qq

# # reference: trunc8
# # run the installation script  
RUN wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true
# # it continues to remain in zsh in future images
SHELL ["/bin/zsh", "-c"]
# # zsh plugins
RUN git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions \
&& git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting


CMD ["zsh"]