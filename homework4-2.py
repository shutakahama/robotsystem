#!/usr/bin/env python

import rospy, actionlib
from opencv_apps.msg import RotatedRectStamped
from move_base_msgs.msg import *
import sys

def cb(msg):
    print msg.rect
    client.cancel_all_goals()
    goal = MoveBaseGoal()
    goal.target_pose.header.stamp = rospy.Time.now()
    goal.target_pose.header.frame_id = "/map"
    goal.target_pose.pose.position.x = 0;
    goal.target_pose.pose.position.y = 0;
    goal.target_pose.pose.orientation.w = 1
    print goal
    client.send_goal(goal)
    print client.wait_for_result()
    sys.exit()

if __name__== '__main__':
    try:
        rospy.init_node('send_goal', anonymous=True)
        client = actionlib.SimpleActionClient('move_base', MoveBaseAction)
        client.wait_for_server()

        rospy.Subscriber('/camshift/track_box', RotatedRectStamped, cb)

        goal = MoveBaseGoal()
        goal.target_pose.header.stamp = rospy.Time.now()
        goal.target_pose.header.frame_id = "/map"
        goal.target_pose.pose.position.x = 3;
        goal.target_pose.pose.position.y = 3;
        goal.target_pose.pose.orientation.w = 1
        print goal
        client.send_goal(goal)
        print client.wait_for_result()
        goal.target_pose.pose.position.x = -3;
        goal.target_pose.pose.position.y = 3;
        goal.target_pose.pose.orientation.w = 1
        print goal
        client.send_goal(goal)
        print client.wait_for_result()
        goal.target_pose.pose.position.x = -3;
        goal.target_pose.pose.position.y = -3;
        goal.target_pose.pose.orientation.w = 1
        print goal
        client.send_goal(goal)
        print client.wait_for_result()
        goal.target_pose.pose.position.x = 3;
        goal.target_pose.pose.position.y = -3;
        goal.target_pose.pose.orientation.w = 1
        print goal
        client.send_goal(goal)
        print client.wait_for_result()
    except rospy.ROSInterruptException: pass
