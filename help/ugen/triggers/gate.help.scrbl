#lang scribble/manual
@(require (for-label racket))

@title{(gate in trig)}


The signal at `in' is passed while `trig' is greater than zero.


@racketblock[
(let ((s (mul (f-sin-osc ar 500 0) 1/4))
      (t (lf-pulse ar 1 0 1/10)))
  (audition (out 0 (gate s t))))
]


