; allocate and fill tables 0 to 7 with a generated list of harmonic amplitudes
(with-sc3
 (lambda (fd)
   (let* ((square
	   (lambda (a) (* a a)))
	  (nth
	   (lambda (i)
	     (async fd (b-alloc i 1024 1))
	     (let* ((n (expt (+ i 1) 2))
		    (a (map (lambda (j)
			      (square (/ (- n j) n)))
			    (enumFromTo 0 (- n 1)))))
	       (async fd (b-gen1 i "sine1" (cons 7 a)))))))
     (for-each nth (enumFromTo 0 7)))))

; v-osc3 ; buffers 0 through 7
(let ((p (mouse-x 0 7 0 0.1))
      (f1 (mce2 240 241))
      (f2 (mce2 240.27 241.1))
      (f3 (mce2 240.43 239.71)))
  (mul (v-osc3 p f1 f2 f3) 0.1))

; reallocate buffers while oscillator is running
(with-sc3
 (lambda (fd)
   (for-each
    (lambda (i)
      (async fd (b-gen1  i "sine1" (cons 7 (replicateM 16 (lambda () (s:rand 0 1)))))))
    (enumFromTo 0 7))))
