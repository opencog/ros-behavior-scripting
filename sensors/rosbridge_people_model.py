#
# face_recog.py - Face Recognition
# Copyright (C) 2016  Hanson Robotics
#
# This library is free software; you can redistribute it and/or
# modify it under the terms of the GNU Lesser General Public
# License as published by the Free Software Foundation; either
# version 2.1 of the License, or (at your option) any later version.
#
# This library is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public
# License along with this library; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
# 02110-1301  USA

import rospy
from atomic_msgs import AtomicMsgs
from ros_people_model.msg import Face
from ros_people_model.msg import Faces

'''
Subscribes to topics published by
    https://github.com/elggem/ros_people_model
and forwards them to OpenCog as per
    https://github.com/opencog/opencog/tree/master/opencog/ghost
'''

EMOTIONS = {
    0 : "anger",
    1 : "disgust",
    2 : "fear",
    3 : "happy",
    4 : "sad",
    5 : "surprise",
    6 : "neutral"
}

# Push information about recognized faces into the atomspace.
class PeopleModel:
	def __init__(self):
		self.atomo = AtomicMsgs()
		rospy.Subscriber('/faces', Faces, self.faces_cb)

	def faces_cb(self, data):
		for face in data.faces:
			if face.face_id is "":
				continue

			self.atomo.perceived_face(face.face_id,
									  face.position.x,
									  face.position.y,
									  face.position.z);

			if len(face.emotions)>0:
				for i, strength in enumerate(face.emotions):
					self.atomo.perceived_emotion(face.face_id,
												 EMOTIONS[i],
												 strength)
