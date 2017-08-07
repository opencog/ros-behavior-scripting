#
# Installation CMake file.
# Currently, used for only one reason only: to install part of the
# OpenCog behavior infrastructure as a guile module, so that other
# dependent code can use it.

CMAKE_MINIMUM_REQUIRED(VERSION 2.6)

# Only list install files that have actually changed
set( CMAKE_INSTALL_MESSAGE "LAZY" )

# The package name MUST match that in the project.xml file
# and, because it's python, must use underscores, not dashes.
PROJECT(ros_behavior_scripting)

# Set datadir
IF (NOT DEFINED DATADIR)
	SET (DATADIR "${CMAKE_INSTALL_PREFIX}/share/opencog")
ENDIF (NOT DEFINED DATADIR)

# ===================================================================
# ROS stuff

# execute_process(COMMAND "bash /opt/ros/indogo/setup.bash")

# The find_package below fails, unless the setup above is sourced,
# first.  Oh well.
find_package(catkin REQUIRED COMPONENTS
  dynamic_reconfigure
  geometry_msgs
  hr_msgs
  pi_face_tracker
  rospy
  std_msgs
)

# ===================================================================
# global includes

ADD_SUBDIRECTORY(movement)
ADD_SUBDIRECTORY(webui)
