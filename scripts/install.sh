#!/bin/bash
#
# Script for building and installing.

GIT_REPO="$(dirname $(readlink -f ${BASH_SOURCE[0]}))/.."

if [ ! -d "$GIT_REPO/build" ]; then
    mkdir "$GIT_REPO/build"
fi

cd $GIT_REPO/build
source /opt/hansonrobotics/ros/setup.bash
cmake ..
sudo make install
