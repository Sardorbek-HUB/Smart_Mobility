#Configuring Environment
# Possible values are: setup.bash, setup.sh, setup.zsh
source /opt/ros/humble/setup.bash

echo "source /opt/ros/humble/setup.bash" >> ~/.bashrc

printenv | grep -i ROS

ROS_VERSION=2
ROS_PYTHON_VERSION=3
ROS_DISTRO=humble

export ROS_DOMAIN_ID=<your_domain_id>

echo "export ROS_DOMAIN_ID=<your_domain_id>" >> ~/.bashrc

export ROS_LOCALHOST_ONLY=1

echo "export ROS_LOCALHOST_ONLY=1" >> ~/.bashrc
