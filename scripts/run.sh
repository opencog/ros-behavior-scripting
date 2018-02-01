#! /bin/bash
#
# Script for running opencog with HEAD.

set -e
_session_name="opencog"

source /opt/hansonrobotics/ros/setup.bash

# hrtool workspace
HR_WS="$(hr env | grep HR_WORKSPACE | cut -d = -f 2)"

# The HEAD setup has its own python virutal environment thus the need to update
# the PYTHONPATH
PYTHON_PATH="${PYTHONPATH}:/usr/local/lib/python2.7/dist-packages"

# Run a robot/simulation.
if [ $# -eq 0 ]; then
  echo "Pass at the robot name, which would be passed on to 'hr run --dev'"
  exit 1
fi

# NOTE: Since the HEAD services may fail randomly, start opencog
# in separate tmux session.
start_opencog_tmux_session()
{
  echo "Start opencog services in a new background tmux session"
  # Start relex
  tmux new-session -d -s "$_session_name" -n "relex" \
    "cd $HR_WS/OpenCog/relex &&
    bash opencog-server.sh;
    $SHELL"

  # Start the cogserver
  tmux new-window -t "$_session_name:" -n "ghost" \
    "cd $HR_WS/OpenCog/ros-behavior-scripting/scripts &&
    guile -l config.scm;
    $SHELL"

  # Start passing sensory inputs to the cogserver
  tmux new-window -t "$_session_name:" -n "rbs" \
    "export PYTHONPATH=$PYTHON_PATH &&
    cd $HR_WS/OpenCog/ros-behavior-scripting/sensors &&
    python main.py ;
    $SHELL"

  echo "Finished starting opencog services in a new background tmux session"
}

# Start opencog tmux session
tmux has-session -t "$_session_name" || start_opencog_tmux_session

# Start HEAD tmux session
tmux has-session -t "$1" || hr run --dev $1

