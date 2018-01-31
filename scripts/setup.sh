#! /bin/bash
#
# Script for setting up HEAD for building rbs
set -e

# TODO move to octool.
GIT_REPO="$(dirname $(readlink -f ${BASH_SOURCE[0]}))/.."

# Install hrtool.
curl https://raw.githubusercontent.com/hansonrobotics/hrtool/master/get_hr.bash|bash
hr install head-hr head-hr-ext
hash -r

# Configure the hansonrobotics workspace.
echo yes | hr init
hr cmd use_git_ssh # use ssh to minimize interactions
hr install head

# Clone opencog repos.
hr update opencog

## Configure ros-behavior-scripting for building using `hr build opencog`
ln -s "$GIT_REPO" "$HR_WS/HEAD/src/ros-behavior-scripting"


printf "Finished configuring setup for running opencog with HEAD \n"
