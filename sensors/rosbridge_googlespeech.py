#
# chat_track.py -  Misc chatbot message handling.
# Copyright (C) 2014,2015,2016  Hanson Robotics
# Copyright (C) 2015,2016 Linas Vepstas
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
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA

import rospy
from atomic_msgs import AtomicMsgs
from hr_msgs.msg import ChatMessage

'''
Subscribes to topics published by
    https://github.com/hansonrobotics/asr/blob/master/scripts/google_speech.py
and forwards them to OpenCog as per
    https://github.com/opencog/opencog/tree/master/opencog/ghost
'''

class GoogleSpeech:

	def __init__(self):
		self.atomo = AtomicMsgs()
		robot_name = rospy.get_param("robot_name")
		rospy.Subscriber(robot_name+"/words", ChatMessage, self.perceived_word)
		rospy.Subscriber(robot_name+"/speech", ChatMessage, self.perceived_sentence)

	def perceived_word(self, msg):
		self.atomo.perceived_word(msg.utterance)

	def perceived_sentence(self, msg):
		self.atomo.perceived_sentence(msg.utterance)
