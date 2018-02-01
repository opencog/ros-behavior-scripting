#!/bin/bash

packages="
  head-asr
  head-basic-head-api
  head-blender-api
  head-blender-api-msgs
  head-cereproc
  head-chatbot
  head-chatscript
  head-chatscript-han
  head-chatscript-sophia
  head-data
  head-deps-all
  head-dynamixel-motor
  head-festival-api
  head-hr
  head-hr-ext
  head-hr-msgs
  head-libmongoc
  head-marky-markov
  head-motors-safety
  head-opencv
  head-pau2motors
  head-perception
  head-performances
  head-pi-vision
  head-pocketsphinx
  head-python-emopy
  head-python-hr-characters
  head-python-iflytek
  head-python-pololu-motors
  head-python-ttsserver
  head-realsense-ros
  head-ros-audio-stream
  head-ros-emotion
  head-ros-misc
  head-ros-pololu
  head-ros-tts
  head-saliency-tracker
  head-sophia-blender-api
  head-sound
  head-sphinxbase
  head-ttsserver-voice-api
  head-webui
"

# A loop is used, because packages installed by hrtool may differ from version
# to version, or installation for some might have failed, and so trying to
# purge all packages in one go might fail.
for i in $packages;do
  sudo apt-get -y purge $i
done
