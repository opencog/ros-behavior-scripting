#! /bin/bash
#
# Script for setting up HEAD for building rbs

curl https://raw.githubusercontent.com/hansonrobotics/hrtool/master/get_hr.bash|bash

hr install head-deps
echo yes | hr init
hr update head
