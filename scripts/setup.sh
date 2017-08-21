#! /bin/bash
#
# Script for setting up HEAD for building rbs

# TODO move to octool.
GIT_REPO="$(dirname $(readlink -f ${BASH_SOURCE[0]}))/.."

# Install hrtool.
curl https://raw.githubusercontent.com/hansonrobotics/hrtool/master/get_hr.bash|bash
hr install -p head-hr head-hr-ext

# Install dependencies for running the robot.
hr install head-deps

# Configure the workspace and clone hansonrobotics repos.
echo yes | hr init
hr cmd get_head
hr update head

# Clone opencog repos.
HR_WS="$(hr env | grep HR_WORKSPACE | cut -d = -f 2)"
if [[ ! -d $HR_WS/opencog ]]; then
  hr cmd get_opencog
  # FIXME: Temporary hack, remove once hrtool starts to use upstream code
  for i in $(ls "$HR_WS/opencog"); do
    git_remote="git -C $HR_WS/opencog/$i remote"
    HR_REMOTE="$(eval $git_remote -v | grep hansonrobotics | \
                  head -1 | cut -f 1)"
    eval $git_remote rename "$HR_REMOTE" "hansonrobotics"
    eval $git_remote add origin git@github.com:opencog/$i.git
    git -C "$HR_WS/opencog/$i" pull origin master
  done
fi

# Configure ros-behavior-scripting for building using `hr build opencog`
ln -s "$GIT_REPO" "$HR_WS/HEAD/src/ros-behavior-scripting"
