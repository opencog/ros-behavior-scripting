#! /bin/bash
#
# Script for running opencog with HEAD.
#
#

set -e
_session_name="opencog"

source /opt/hansonrobotics/ros/setup.bash

# hrtool workspace
HR_WS="$(hr env | grep HR_WORKSPACE | cut -d = -f 2)"

# The HEAD setup has its own python virutal environment thus the need to update
# the PYTHONPATH
PYTHON_PATH="${PYTHONPATH}:/usr/local/lib/python2.7/dist-packages"

# start opencog processes in tmux session.
start_opencog_tmux_session()
{
  echo "Start opencog services in a new background tmux session"
  # Start relex
  tmux new-session -d -s "$_session_name" -n "relex" \
    "cd $HR_WS/OpenCog/relex &&
    bash opencog-server.sh;
    $SHELL"

  # Start the cogserver
  tmux new-window -t "$_session_name:" -n "cogserver" \
    "cd $HR_WS/OpenCog/ros-behavior-scripting/scripts &&
    guile -l config.scm;
    $SHELL"

  # Start passing sensory inputs to the cogserver
  tmux new-window -t "$_session_name:" -n "rbs" \
    "export PYTHONPATH=$PYTHON_PATH &&
    cd $HR_WS/OpenCog/ros-behavior-scripting/sensors &&
    python main.py ;
    $SHELL"

  # Start perception of emotions
  # TODO: To be integrated into HEAD in v02
  tmux new-window -t "$_session_name:" -n "perception" \
    "roslaunch ros_peoplemodel devhead.launch ;
    $SHELL"

  # Start a shell to cogserver
  tmux new-window -t "$_session_name:" -n "cogserver-shell" \
    "while ! nc -z localhost 17001; do sleep 0.1; done
    rlwrap telnet localhost 17001;
    $SHELL"

  echo "Finished starting opencog services in a new background tmux session"
}

# Start opencog tmux session
tmux has-session -t "$_session_name" || start_opencog_tmux_session

tmux a -t "$_session_name"
