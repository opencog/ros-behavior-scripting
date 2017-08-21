#! /bin/bash
#
# Script for running opencog with HEAD.


source /opt/hansonrobotics/ros/setup.bash

# hrtool workspace
HR_WS="$(hr env | grep HR_WORKSPACE | cut -d = -f 2)"

# The HEAD setup has its own python virutal environment thus the need to update
# the PYTHONPATH
PYTHON_PATH="${PYTHONPATH}:/usr/local/lib/python2.7/dist-packages"

# Run a robot/simulation.
if [ $# -eq 0 ]; then
  echo "Pass at least the robot name, which would be passed on to 'hr run'"
  exit 1
fi

hr run $1

# Start the cogserver
tmux new-window -n "openpsi" \
  "export PYTHONPATH=$PYTHON_PATH &&
  cd $HR_WS/opencog/opencog/opencog/eva/src/ &&
  guile -l btree-psi.scm ;
  $SHELL"

# Start passing sensory inputs to the cogserver
tmux new-window -n "rbs" \
  "export PYTHONPATH=$PYTHON_PATH &&
  cd $HR_WS/opencog/ros-behavior-scripting/sensors &&
  python main.py ;
  $SHELL"
