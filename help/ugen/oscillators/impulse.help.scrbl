#lang scribble/manual
@(require (for-label racket))

@title{impulse}


@racketblock[
(import (rsc3))
]


@racketblock[
(audition (out 0 (mul (impulse ar 800 0) 0.1)))
]


@racketblock[
(let ((f (x-line kr 800 10 5 remove-synth)))
  (audition (out 0 (mul (impulse ar f 0.0) 0.5))))
]


@racketblock[
(let ((f (mouse-y* kr 4 8 0 0.1))
      (p (mouse-x* kr 0 1 0 0.1)))
  (audition (out 0 (mul (impulse ar f (mce2 0 p)) 0.2))))
]


