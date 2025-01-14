#lang scribble/manual
@(require (for-label racket))

@title{(buf-frames rate bufnum)}


Current duration of buffer.


@racketblock[
(with-sc3
 (lambda (fd)
   (async fd (b-alloc-read 0 "/home/rohan/audio/metal.wav" 0 0))))
]


@racketblock[
(let ((p (phasor ar 0 (buf-rate-scale kr 0) 0 (buf-frames kr 0) 0)))
  (audition (out 0 (buf-rd 1 ar 0 p 0 2))))
]


@racketblock[
(let ((p (k2a (mouse-x kr 0 (buf-frames kr 0) 0 0.1))))
  (audition (out 0 (buf-rd 1 ar 0 p 0 2))))
]


