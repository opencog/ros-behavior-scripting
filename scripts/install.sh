#!/bin/bash
#
# Script for building and installing.

SOURCE_DIR=$(git rev-parse --show-toplevel)
if [ ! -d "$SOURCE_DIR/build" ]; then
    mkdir "$SOURCE_DIR/build"
fi

cd build
source /opt/hansonrobotics/ros/setup.bash
cmake ..
sudo make install
