;ROSで部屋の４隅を順番に回るロボット
#! /usr/bin/env roseus

(ros::load-ros-manifest "roseus")
(ros::load-ros-manifest "move_base_msgs")

(ros::roseus "send_goal" :anonymous t)
(setq *c* (instance ros::simple-action-client :init "move_base" move_base_msgs::MoveBaseAction))

(send *c* :wait-for-server)
(setq goal (instance move_base_msgs::MoveBaseActionGoal :init))
(send goal :goal :target_pose :header :frame_id "/map")
(send goal :goal :target_pose :pose :position :x 3)
(send goal :goal :target_pose :pose :position :y 3)
(send goal :goal :target_pose :pose :orientation :w 1)
(describe goal)
(send *c* :send-goal goal)
(send *c* :wait-for-result)

(send *c* :wait-for-server)
(setq goal (instance move_base_msgs::MoveBaseActionGoal :init))
(send goal :goal :target_pose :header :frame_id "/map")
(send goal :goal :target_pose :pose :position :x -3)
(send goal :goal :target_pose :pose :position :y 3)
(send goal :goal :target_pose :pose :orientation :w 1)
(describe goal)
(send *c* :send-goal goal)
(send *c* :wait-for-result)

(send *c* :wait-for-server)
(setq goal (instance move_base_msgs::MoveBaseActionGoal :init))
(send goal :goal :target_pose :header :frame_id "/map")
(send goal :goal :target_pose :pose :position :x -3)
(send goal :goal :target_pose :pose :position :y -3)
(send goal :goal :target_pose :pose :orientation :w 1)
(describe goal)
(send *c* :send-goal goal)
(send *c* :wait-for-result)

(send *c* :wait-for-server)
(setq goal (instance move_base_msgs::MoveBaseActionGoal :init))
(send goal :goal :target_pose :header :frame_id "/map")
(send goal :goal :target_pose :pose :position :x 3)
(send goal :goal :target_pose :pose :position :y -3)
(send goal :goal :target_pose :pose :orientation :w 1)
(describe goal)
(send *c* :send-goal goal)
(send *c* :wait-for-result)

