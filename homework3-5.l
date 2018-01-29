;7自由度アーム
(defclass 8dof-robot
  :super cascaded-link
  :slots (end-coords l1 l2 l3 l4 l5 l6 l7 l8 j1 j2 j3 j4 j5 j6 j7))
(defmethod 8dof-robot
  (:init ()
	 (let (b)
	   (send-super :init)
	   
	   (setq b (make-cube 10 10 20))
	   (send b :locate #f(0 0 10))
	   (send b :set-color :yellow)
	   (setq l8 (instance bodyset-link :init (make-cascoords) :bodies (list b)))
	   (setq end-coords (make-cascoords :pos #f(0 0 20)))
	   (send l8 :assoc end-coords)
	   (send l8 :locate #f(0 0 100))
	   
	   (setq b (make-cube 10 10 100))
	   (send b :locate #f(0 0 50))
	   (send b :set-color :pink)
	   (setq l7 (instance bodyset-link :init (make-cascoords) :bodies (list b)))
	   (send l7 :assoc l8)
	   (send l7 :locate #f(0 0 100))
	   
	   (setq b (make-cube 10 10 100))
	   (send b :locate #f(0 0 50))
	   (send b :set-color :gray)
	   (setq l6 (instance bodyset-link :init (make-cascoords) :bodies (list b)))
	   (send l6 :assoc l7)
	   (send l6 :locate #f(0 0 100))
	   
	   (setq b (make-cube 10 10 100))
	   (send b :locate #f(0 0 50))
	   (send b :set-color :orange)
	   (setq l5 (instance bodyset-link :init (make-cascoords) :bodies (list b)))
	   (send l5 :assoc l6)
	   (send l5 :locate #f(0 0 100))
	   
	   (setq b (make-cube 10 10 100))
	   (send b :locate #f(0 0 50))
	   (send b :set-color :red)
	   (setq l4 (instance bodyset-link :init (make-cascoords) :bodies (list b)))
	   (send l4 :assoc l5)
	   (send l4 :locate #f(0 0 100))
	   
	   (setq b (make-cube 10 10 100))
	   (send b :locate #f(0 0 50))
	   (send b :set-color :green)
	   (setq l3 (instance bodyset-link :init (make-cascoords) :bodies (list b)))
	   (send l3 :assoc l4)
	   (send l3 :locate #f(0 0 100))
	   
	   (setq b (make-cube 10 10 100))
	   (send b :locate #f(0 0 50))
	   (send b :set-color :blue)
	   (setq l2 (instance bodyset-link :init (make-cascoords) :bodies (list b)))
	   (send l2 :assoc l3)
	   (send l2 :locate #f(0 0 20))
	   
	   (setq b (body+ (make-cube 10 10 20 :pos #f(0 0 10)) (make-cube 300 300 2)))
	   (send b :set-color :white)
	   (setq l1 (instance bodyset-link :init (make-cascoords) :bodies (list b)))
	   (send l1 :assoc l2)
	   
	   (setq j1 (instance rotational-joint :init
			      :parent-link l1 :child-link l2 :axis :y :min -100 :max 100)
		 j2 (instance rotational-joint :init
			      :parent-link l2 :child-link l3 :axis :x :min -100 :max 100)
		 j3 (instance rotational-joint :init
			      :parent-link l3 :child-link l4 :axis :z :min -100 :max 100)
		 j4 (instance rotational-joint :init
			      :parent-link l4 :child-link l5 :axis :y :min -100 :max 100)
		 j5 (instance rotational-joint :init
			      :parent-link l5 :child-link l6 :axis :x :min -100 :max 100)
		 j6 (instance rotational-joint :init
			      :parent-link l6 :child-link l7 :axis :z :min -100 :max 100)
		 j7 (instance rotational-joint :init
			      :parent-link l7 :child-link l8 :axis :x :min -100 :max 100))
	   
	   (setq links (list l1 l2 l3 l4 l5 l6 l7 l8))
	   (setq joint-list (list j1 j2 j3 j4 j5 j6 j7))
	   
	   (send self :init-ending)
	   self))
  (:end-coords (&rest args) (forward-message-to end-coords args))
  )

(setq r (instance 8dof-robot :init))
(objects (list r))
(send r :angle-vector #f(0 0 0 0 0 0 0))
(setq i 0)
(do-until-key
  (setq c (make-cascoords :pos (float-vector (* 50 (cos (/ i 10))) 400 (+ 300 (* 50 (sin (/ i 10))))) :rpy (float-vector 0 0 (/ -pi 2))))
  (send r :inverse-kinematics c
	:link-list (send r :link-list (send r :end-coords :parent))
	:move-target (send r :end-coords)
	:translation-axis t
	:thre 50
	:rotation-axis t
	:revert-if-fail nil
	:cog-null-space nil)
  (x::window-main-one)
  (send *irtviewer* :draw-objects :flush nil)
  (send c :draw-on :flush t)
  (incf i)
  )
