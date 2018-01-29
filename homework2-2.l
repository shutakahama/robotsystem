;2-1 再帰
(defun period11 (count1 n)
  (if (eql n 0)
    (dotimes (i count1) (print '.))
    (period11 (+ count1 1) (- n 1))))

(defun period1 (n)
  (period11 0 n))

;2-1 反復
(defun period2 (n)
  (dotimes (i n) (print '.)))

;2-2 再帰
(defun asearch11 (lst count1)
  (if (null lst)
      count1
    (progn (if (eql (car lst) 'a)
	       (setq count1 (+ count1 1)))
	   (asearch11 (cdr lst) count1))))

(defun asearch1 (lst)
  (asearch11 lst 0))

;2-2 反復
(defun asearch2 (lst2)
  (setq count2 0)
  (dolist (key lst2)
    (if (eql key 'a)
	(setq count2 (+ count2 1))))
  count2)
