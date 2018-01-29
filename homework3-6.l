;研究室内で動作するロボット
(load "models/room73b2-scene.l")
(load "models/h7-robot.l")
(setq *room* (room73b2))
(setq *robot* (h7))
(objects (list *robot* *room*))

(send *robot* :reset-pose)

(send *robot* :move-to (send *room* :spot "/eng2/7f/room73B2-front-kitchen-table") :world)
(send *robot* :locate #f(0 0 550))
(send *robot* :rotate (deg2rad 180) :z)

(send *irtviewer* :look-all
      (geo::make-bounding-box
       (flatten (send-all (send *robot* :bodies) :vertices))))

(setq *obj* (send *room* :object "room73b2-sushi-cup2"))
(if (send *obj* :parent) (send (send *obj* :parent) :dissoc *obj*))
(send *robot* :head :look-at (send *obj* :worldpos))

(send *robot* :rarm :inverse-kinematics
      (car (send *obj* :handle))
      :link-list (send *robot* :link-list (send *robot* :rarm :end-coords :parent))
      :move-target (send *robot* :rarm :end-coords)
      :rotation-axis :z
      :debug-view t)

(send *robot* :rarm :end-coords :assoc *obj*)
(send *robot* :rarm :move-end-pos #f(0 0 200) :world
      :debug-view t :look-at-target t)
