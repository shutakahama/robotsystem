;風呂と蛇口の水のモデル
(defun suidou1 nil
  (let (b1 b2 b3)
    (setq b1 (make-cube 3 16 3))
    (setq b2 (make-cube 3 16 3))
    (send b1 :locate #f(0 0 8))
    (send b2 :locate #f(0 0 8))
    (send b2 :rotate (deg2rad 90) :z)
    (setq b1 (body+ b1 b2))
    (setq b3 (make-cylinder 2 10))
    (setq b1 (body+ b1 b3))
    (send b1 :set-color :gray)
    b1))

(defun suidou2 nil
  (let (b1 b2 b3 b4)
    (setq b1 (make-cube 10 60 6))
    (setq b2 (make-cylinder 4 4))
    (setq b3 (make-cylinder 3 4))
    (setq b4 (make-cylinder 4.8 20))
    (send b1 :locate #f(0 24 -1))
    (send b2 :locate #f(0 48 -8))
    (send b3 :locate #f(0 48 -8))
    (send b4 :locate #f(0 0 -20))
    (setq b2 (body- b2 b3))
    (setq b1 (body+ b1 b2 b4))
    (send b1 :set-color :pink)
    b1))

(defun huro nil
  (let (b1 b2 b3)
    (setq b1 (make-cube 160 320 160))
    (setq b2 (make-cube 120 240 120))
    (setq b3 (make-cube 400 600 62))
    (send b2 :locate #f(0 0 20))
    (send b3 :locate #f(-120 140 -111))
    (setq b1 (body- b1 b2))
    (setq b1 (body+ b1 b3))
    (send b1 :locate #f(0 130 -100))
    (send b1 :set-color :white)
    b1))

(defun water1 nil
  (let (b1)
    (setq b1 (make-cylinder 3 140))
    (send b1 :locate #f(0 48 -140))
    (send b1 :set-color :blue)
    b1))


(defun water2 nil
  (let (b1)
    (setq b1 (make-cube 120 240 100))
    (send b1 :locate #f(0 130 -140))
    (send b1 :set-color :blue)
    b1))

(defclass suidou
  :super cascaded-link
  :slots (end-coords h1 h2 j1))
(defmethod suidou
  (:init ()
	 (let (b)
	   (send-super :init)
	   (setq h1 (instance bodyset-link :init (make-cascoords) :bodies (list (suidou2))))
	   (setq h2 (instance bodyset-link :init (make-cascoords) :bodies (list (suidou1))))

	   (setq j1 (instance rotational-joint :init :parent-link h1 :child-link h2 :axis :z))

	   (setq links (list h1 h2))
	   (setq joint-list (list j1))

	   (send self :init-ending)
	   self))
  (:j1 (&rest args) (forward-messae-to j1 args))
  )

(defclass yubune
  :super cascaded-link
  :slots (end-coords h3 h4 j2))
(defmethod yubune
  (:init ()
	 (let (b)
	   (send-super :init)
	   (setq h3 (instance bodyset-link :init (make-cascoords) :bodies (list (huro))))
	   (setq h4 (instance bodyset-link :init (make-cascoords) :bodies (list (water2))))

	   (setq j2 (instance linear-joint :init :parent-link h3 :child-link h4 :axis :z))

	   (setq links (list h3 h4))
	   (setq joint-list (list j2))

	   (send self :init-ending)
	   self))
  (:j2 (&rest args) (forward-messae-to j2 args))
  )



(setq r1 (instance suidou :init))
(setq r2 (instance yubune :init))
(setq r3 (water1))
(objects (list r1 r2))

(dotimes (i 100)
  (send r2 :angle-vector (float-vector -50.5))
  (send *irtviewer* :draw-objects)
  (incf i))


(dotimes (i 180)
  (send r1 :angle-vector (float-vector (- i 90)))
  (if (> i 120)
      (progn (objects (list r1 r2 r3))
	     (send r2 :angle-vector (float-vector (/ (- i 220) 2)))
	     ))
  (send *irtviewer* :draw-objects)
  (incf i))

(dotimes (i 80)
  (objects (list r1 r2 r3))
  (send r2 :angle-vector (float-vector (/ (- i 40) 2)))
  )
  
(dotimes (i 180)
  (if (< i 60)
      (progn (objects (list r1 r2 r3))
	     (send r2 :angle-vector (float-vector (/ (+ i 40) 2)))
	     )
    (objects (list r1 r2))
    )
  (send r1 :angle-vector (float-vector (- 90 i)))
  (send *irtviewer* :draw-objects)
  (incf i))
