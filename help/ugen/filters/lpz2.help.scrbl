#lang scribble/manual
@(require (for-label racket))

@title{(lpz2 ar in)}


Two zero fixed lowpass filter


@racketblock[
(audition
 (out 0 (lpz2 (mul (white-noise ar) 0.25))))
]


