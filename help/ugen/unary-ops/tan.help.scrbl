#lang scribble/manual
@(require (for-label racket))

@title{(u:tan a)}


Tangent.


@racketblock[
(let* ((a (line kr (- pi) pi 1 remove-synth))
       (b (sub (fdiv (u:tan a) (/ pi 2)) 1))
       (f (mul-add b 900 1600)))
  (audition 
   (out 0 (mul (sin-osc ar f 0) 0.1))))
]


