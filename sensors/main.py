#! /usr/bin/env python
#
# main.py - Main entry point for the ROS-to-OpenCog converter
# Copyright (C) 2015  Hanson Robotics
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License v3 as
# published by the Free Software Foundation and including the exceptions
# at http://opencog.org/wiki/Licenses
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public
# License
# along with this program; if not, write to:
# Free Software Foundation, Inc.,
# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.

# XXX To be removed when https://github.com/hansonrobotics/HEAD/issues/618
# is resolved nicely
import sys

sys.path.append("/opt/hansonrobotics/ros/lib/python2.7/dist-packages/")

import logging
import rospy

from rosbridge_googlespeech import GoogleSpeech
from rosbridge_people_model import PeopleModel

rospy.init_node("OpenCog_ROS_bridge")
logging.info("Starting the OpenCog ROS Bridge")
print("Starting the OpenCog ROS Bridge")

googlespeech = GoogleSpeech()
peoplemodel = PeopleModel()

try:
    rospy.spin()
except rospy.ROSInterruptException as e:
    print(e)

print("Exit OpenCog ROS bridge")
