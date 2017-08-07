#! /bin/bash
#
# Script for setting up HEAD for building rbs

# TODO move to octool.
GIT_REPO="$(dirname $(readlink -f ${BASH_SOURCE[0]}))/.."

curl https://raw.githubusercontent.com/hansonrobotics/hrtool/master/get_hr.bash|bash

hr install head-deps
echo yes | hr init
hr update head
hr cmd get_head
ln -s "$GIT_REPO" ~/hansonrobotics/HEAD/src/ros-behavior-scripting
