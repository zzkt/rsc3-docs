#lang scribble/manual
@(require (for-label racket))

@title{(arc-cos a)}


Arc cosine.


@racketblock[
(let* ((a (line kr -1 1 1 remove-synth))
       (b (sub (fdiv (arc-cos a) (/ pi 2)) 1))
       (f (mul-add b 900 1600)))
  (audition 
   (out 0 (mul (sin-osc ar f 0) 0.1))))
]


