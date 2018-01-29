(defun summit1 (lst)
  (apply #'+ (remove nil lst)))

(defun summit2 (lst)
  (if (null lst)
    0
    (let ((x (car lst)))
      (if (null x)
	(summit2 (cdr lst))
        (+ x (summit2 (cdr lst))))))


#|
summit1:
removeは非破壊的関数であるため、removeを実行してもその変化が保存されない。よってapplyの中でremoveを行う。setqなどで新たに定義してもよい。

summit2:
再帰を用いているのにlstが空になったときの返り値が指定されておらず、再帰が終わらないのでコアダンプが出る。はじめに(null lst)の場合を指定する。
|#
