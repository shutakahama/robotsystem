;直動ジョイント
(defun makelinear1 nil
  (let (b1 b2)
    (setq b1 (make-cube 40 30 150))
    (send b1 :locate #f(0 0 0))
    (setq b2 (make-cube 30 20 130))
    (send b2 :locate #f(0 5 0))
    (setq b1 (body- b1 b2))
    (send b1 :set-color :gray20)
    b1))

(defun makelinear2 nil
  (let ((b3 (make-cylinder 3 150))
	(b4 (make-cube 20 20 30)))
    (send b3 :locate #f(0 0 -60))
    (send b4 :locate #f(0 0 105))
    (setq b3 (body+ b3 b4))
    (send b3 :set-color :gray80)
    b3))

(defclass linearjoint
  :super cascaded-link
  :slots (a1 a2 j1))
(defmethod linearjoint
  (:init()
	(let ()
	  (send-super :init)
	  (setq a1 (instance bodyset-link :init (make-cascoords) :bodies (list (makelinear1))))
	  (setq a2 (instance bodyset-link :init (make-cascoords) :bodies (list (makelinear2))))

	  (setq j1 (instance linear-joint :init :parent-link a1 :child-link a2 :axis :z))

	  (setq links (list a1 a2))
	  (setq joint-list (list j1))

	  (send self :assoc a1)
	  (send a1 :assoc a2)

	  (send self :init-ending)
	  self

	  (objects (list self))
	  (setq i 0)
	  (do-until-key
	   (send self :angle-vector (float-vector (+ 40 (* 40 (sin (/ i 10.0))))))
	   (send *irtviewer* :draw-objects)
	    (incf i))
	  ))
  )
(setq r (instance linearjoint :init))

