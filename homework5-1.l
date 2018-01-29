#! /usr/bin/env roseus

(ros::load-ros-manifest "roseus")
(ros::load-ros-manifest "actionlib_tutorials")
(ros::load-ros-manifest "move_base_msgs")

(ros::roseus "send_goal" :anonymous t)
(setq *c* (instance ros::simple-action-client :init "move_base" actionlib_tutolials::MoveBaseAction))

(send *c* :wait-for-server)
(setq goal (instance sctionlib_tutorials::MoveBaseActionGoal :init))
(send goal :goal :target-pose :header :frame-id "/map")
(send goal :target-pose :pose :position :x 3)
(send goal :target-pose :pose :position :y 3)
(send goal :target-pose :pose :orientation :w 1)
(send *c* :send-goal goal)
(send *c* :wait-for-server)
(send (send *c* :get-result) :sepuence)
