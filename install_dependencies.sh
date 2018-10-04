#!/bin/bash


#################################
#     Additional Packages
################################
read -n1 -p "Do you need to install the additional ROS Dependencies? Enter (y) or (n)" doit
echo
if [[ $doit == "Y" || $doit == "y" ]]; then
     # Joystick drivers for robot control
     sudo apt install ros-kinetic-joy ros-kinetic-joystick-drivers ros-kinetic-joy-teleop ros-kinetic-teleop-twist-joy
     # Drivers for robot navigation
     sudo apt install ros-kinetic-gmapping ros-kinetic-amcl ros-kinetic-move-base ros-kinetic-map-server ros-kinetic-hector-gazebo*

	# ErleCopter packages
	sudo apt install ros-kinetic-mavros ros-kinetic-mavros-msgs ros-kinetic-mav-msgs ros-kinetic-mavlink
	sudo apt install ros-kinetic-octomap-msgs ros-kinetic-octomap-ros
	sudo apt install ros-kinetic-geodesy-ros
	sudo apt install ros-kinetic-control-toolbox ros-kinetic-transmission-interface ros-kinetic-joint-limits-interface
fi
echo

#################################
#     Erle-Copter Dependencies
################################
read -n1 -p "Do you need to install the Erle-Copter Dependencies? Enter (y) or (n)" doit
echo
if [[ $doit == "Y" || $doit == "y" ]]; then
     sudo apt-get install gawk make git curl cmake -y
	sudo apt-get install libgoogle-glog-dev -y
     sudo apt-get install python-pip python-serial python-pyparsing ccache realpath python-rosinstall unzip

     # Install MavLink MAVProxy
     sudo pip install future mavproxy pymavlink
     sudo apt-get install libxml2-dev libxslt1-dev -y
     sudo pip install MAVProxy==1.5.2
fi
echo


#################################
#  Ardupilot Repo Dependencies
################################
read -n1 -p "Do you need to clone the repo dependencies? Enter (y) or (n)" doit
echo
if [[ $doit == "Y" || $doit == "y" ]]; then
     git clone https://github.com/erlerobot/ardupilot -b gazebo
     git clone https://github.com/ethz-asl/glog_catkin.git
     git clone https://github.com/catkin/catkin_simple.git
     git clone https://github.com/erlerobot/rotors_simulator.git
     git clone https://github.com/Hlwy/ardupilot_sitl_gazebo_plugin.git
     git clone https://github.com/erlerobot/mavros.git
     git clone https://github.com/PX4/mav_comm.git

     cp glog_catkin/fix-unused-typedef-warning.patch ../

     # cd /opt/ros/kinetic/lib/mavros/
     # sudo ./install_geographiclib_dataset.sh
fi
echo

############################
#  Clone Terrasentia Repo
############################
# read -n1 -p "Do you need to get the terrasentia-gazebo repo? Enter (y) or (n)" doit
# echo
# if [[ $doit == "Y" || $doit == "y" ]]; then
#      echo Please type in your git or bitbucket username.
#      read username
#
#      cd $HOME
#      mkdir -p catkin_ws/src
#      cd catkin_ws/src
#
#      git clone https://$username@bitbucket.org/daslab_uiuc/terrasentia-gazebo.git
#      ros_ws=$HOME/catkin_ws
#
#      terra_gazebo_path="$ros_ws/src/terrasentia-gazebo"
#
# else
#      echo "What is the path to your working ROS workspace?"
#      read ros_ws
#
#      terra_gazebo_path="$ros_ws/src/terrasentia-gazebo"
# fi
# echo
# echo "The terrasentia-gazebo path: $terra_gazebo_path"

###########################
#  	Build Everything
###########################
# echo
# read -n1 -p "Do you want to build your workspace? Enter (y) or (n)" doit
#
# if [[ $doit == "Y" || $doit == "y" ]]; then
#      cd $ros_ws
#      catkin_make
#      source devel/setup.bash
# fi

echo
echo Done!
echo
echo
echo Before running 'catkin_make' You will need to run the following to successfully build Ardupilot packages:
echo "     catkin_make --pkg mav_msgs mavros_msgs"
