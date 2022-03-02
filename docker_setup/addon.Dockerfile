FROM rd-base

RUN sudo apt-get update \
	&& sudo -E apt-get install -y -qq \
	&& sudo apt-get install -y -qq \
    ros-melodic-py-trees-ros \
    ros-melodic-tf2-sensor-msgs \
    ros-melodic-geographic-msgs \
    # ros-melodic-geographic-lib \
    ros-melodic-tf2-geometry-msgs \
    ros-melodic-ackermann-msgs \
    ros-melodic-joy \
    ros-melodic-map-server \
  && sudo apt-get clean -qq


RUN rosdep update

