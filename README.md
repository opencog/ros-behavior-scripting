Eva Robot ROS Sensory+Motor API
===============================
This repo contains ROS nodes for sensory input (vision, audio) and
motor movements for the Hanson Robotics Eva robot.  Previously, this
repo used to contain more of the subsystem, but all of that code has
been moved to the main OpenCog repo:

https://github.com/opencog/opencog/tree/master/opencog/eva

What is left here is an assortment of ROS nodes that subscribe
to ROS visual and audio sensory inputs, and forward these to the
OpenCog spactime server (performing the needed format conversion).

Design goals
------------
Provide a convenient, flexible interface between ROS and the OpenCog
servers.

Current Architecture and Design
-------------------------------
At this time, the code here provides a perception subsystem:

 * Several ROS nodes that forward visual and sound data to the
   OpenCog spacetime server. This includes 3D locations of visible
   faces, the names of any recognized faces (as recognized by some
   external software), the direction from which sounds are coming
   from, and audio-power samples.

   (This needs to be replaced by a (much) better visual system.)

Some things it currently doesn't do, but should:

 * Integrate superior face-tracking and face recognition tools.
   Right now, the face tracker is recognizes known faces only with
   difficulty.

 * Additional sensory systems and sensory inputs.  A perception
   synthesizer to coordinate all sensory input. High priority:

  ++ Audio power envelope (half-done, see `sensors/audio_power.py`),
     fundamental frequency (of voice), rising/falling tone.
     Background audio power. Length of silent pauses.  Detection
     of applause, laughter, loud voices in the background, loud
     bangs.

  ++ Video-chaos: Is it light or dark? Is there lots of random
     motion in the visual field, or are things visually settled?

Status
------
It works and is in regular (daily) use (2015, 2016, 2017...).

Setup
-------
Initial setup, only needed to be run once.
```
bash scripts/setup.sh
```

Install
-------
Run the following commands.
```
bash scripts/install.sh
```

Running
-------
Run the following commands.
```
bash scripts/run.sh <robot-name>
```
<robot-name> could be `han` or `sophia10`

TODO
----
 * Need major overhaul of the time-space server API's. Need to be able
   to query them with pattern matcher
 * Need to create time-query atoms
 * Need to place sound-source direction into the space-server. (i.e. currently
   in time-map.scm map-sound)
