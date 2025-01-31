#lang scribble/manual
@(require (for-label racket))

@title{(most-change a b)}


output the input that changed most.


@racketblock[
(let* ((x (mouse-x kr 200 300 0 0.1))
       (f (most-change (mul-add (lf-noise0 kr 1) 400 900) x)))
  (audition (out 0 (mul (sin-osc ar f 0) 0.1))))
]


