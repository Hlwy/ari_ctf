#!/bin/bash

#################################################
#     Install Full ROS Kinetic for Ubuntu 16.04
#################################################

read -n1 -p "Do you need to install ROS? Enter (y) or (n)" doit
echo
if [[ $doit == "Y" || $doit == "y" ]]; then
     # Setup your sources.list
     sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'

     # Setup your keys
     sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116

     # Install Desktop-Full
     sudo apt-get update
     sudo apt-get install -y ros-kinetic-desktop-full

     # Initialize rosdep
     sudo rosdep init
     rosdep update

     # Setup bash Environment Loading
     echo "source /opt/ros/kinetic/setup.bash" >> ~/.bashrc
     source ~/.bashrc
     source /opt/ros/kinetic/setup.bash
fi


#################################
#     Additional Packages
################################
read -n1 -p "Do you need to install the additional ROS packages? Enter (y) or (n)" doit
echo
if [[ $doit == "Y" || $doit == "y" ]]; then
     # Joystick drivers for robot control
     sudo apt install ros-kinetic-joy ros-kinetic-joystick-drivers ros-kinetic-joy-teleop ros-kinetic-teleop-twist-joy
     # Drivers for robot navigation
     sudo apt install ros-kinetic-gmapping ros-kinetic-amcl ros-kinetic-move-base ros-kinetic-map-server ros-kinetic-hector-gazebo*

	sudo apt install ros-kinetic-mavros ros-kinetic-mavros-msgs ros-kinetic-mav-msgs
	sudo apt install ros-kinetic-octomap-msgs
	sudo apt install ros-kinetic-octomap-ros
fi
echo

############################
#  Clone Terrasentia Repo
############################
read -n1 -p "Do you need to get the terrasentia-gazebo repo? Enter (y) or (n)" doit
echo
if [[ $doit == "Y" || $doit == "y" ]]; then
     echo Please type in your git or bitbucket username.
     read username

     cd $HOME
     mkdir -p catkin_ws/src
     cd catkin_ws/src

     git clone https://$username@bitbucket.org/daslab_uiuc/terrasentia-gazebo.git
     ros_ws=$HOME/catkin_ws

     terra_gazebo_path="$ros_ws/src/terrasentia-gazebo"

else
     echo "What is the path to your working ROS workspace?"
     read ros_ws

     terra_gazebo_path="$ros_ws/src/terrasentia-gazebo"
fi
echo
echo "The terrasentia-gazebo path: $terra_gazebo_path"

git clone https://github.com/ethz-asl/glog_catkin.git
git clone https://github.com/catkin/catkin_simple.git
git clone https://github.com/erlerobot/rotors_simulator.git
git clone https://github.com/erlerobot/ardupilot_sitl_gazebo_plugin.git
git clone https://github.com/PX4/mav_comm.git


#################################################
#     Install Full ROS Kinetic for Ubuntu 16.04
#################################################
sudo pip install future mavproxy pymavlink

cd /opt/ros/kinetic/lib/mavros/
sudo ./install_geographiclib_dataset.sh


###########################
#  	Build Everything
###########################
echo
read -n1 -p "Do you want to build your workspace? Enter (y) or (n)" doit

if [[ $doit == "Y" || $doit == "y" ]]; then
     cd $ros_ws
     catkin_make
     source devel/setup.bash
fi

echo
echo Done!
