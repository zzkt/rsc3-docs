#lang scribble/manual
@(require (for-label racket))

@title{(exp a)}


Exponential.


@racketblock[
(let* ((a (line ar -2 2 3 remove-synth))
       (b (u:exp a))
       (f (mul-add (mce2 a b) 600 900)))
  (audition 
   (out 0 (mul (sin-osc ar f 0) 0.1))))
]


