#lang scribble/manual
@(require (for-label racket))

@title{(lpz1 ar in)}


Two point average filter


@racketblock[
(audition
 (out 0 (lpz1 (mul (white-noise ar) 0.25))))
]

