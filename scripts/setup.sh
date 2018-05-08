#! /bin/bash
#
# Bootstrap script for setting up OpenCog after installing HEAD
# stack. Before running, follow instructions to install HEAD:
#
#   https://github.com/hansonrobotics/hrtool
#
# @elggem: Based on my current observations in using this script,
# some of the steps are incomplete. Will append and augment this
# as soon as possible.
#

set -e
GIT_REPO="$(dirname $(readlink -f ${BASH_SOURCE[0]}))/.."

# Install octool
cd "$(dirname "$0")"
wget http://raw.github.com/opencog/ocpkg/master/ocpkg -O octool && chmod +rx octool && ./octool -h

# Clone opencog repos.
hr update opencog
# Install dependencies of OpenCog
# ./octool -...
# Build OpenCog
hr build opencog

## Configure ros-behavior-scripting for building using `hr build opencog`
ln -s "$GIT_REPO" "$HR_WS/HEAD/src/ros-behavior-scripting"

## build ros-behaviour-scripting
hr build head

printf "Finished configuring setup for running opencog with HEAD \n"
