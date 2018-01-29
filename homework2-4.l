;分数の計算
(defclass rational
  :super propertied-object
  :slots (top bottom))
(defmethod rational
  (:init (&optional n d)
	 (send self :set-top n)
	 (send self :set-bottom d)
	 self)
  (:set-top (n) (setq top n))
  (:set-bottom (d) (setq bottom d))
  (:print ()
	  (format t "~A / ~A~%" top bottom))
  (:get-top () top)
  (:get-bottom () bottom)
  )

(defun addrat (a b)
  (setq ans (instance rational :init (+ (* (send a :get-top) (send b :get-bottom))
					(* (send b :get-top) (send a :get-bottom)))
		      (* (send a :get-bottom) (send b :get-bottom)))
	)
  (send a :print)
  (send b :print)
  (send ans :print)
  )


(setq p1 (instance rational :init 2 5))
(setq p2 (instance rational :init 2 3))
(addrat p1 p2)
