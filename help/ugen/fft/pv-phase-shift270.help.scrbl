#lang scribble/manual
@(require (for-label racket))

@title{(pv-phase-shift270 buffer)}


Swap the real and imaginary components of every bin at `buffer' and
swap the sign of the real components.


@racketblock[
(with-sc3
 (lambda (fd)
   (async fd (b-alloc 10 2048 1))))
]


@racketblock[
(let ((n (mul (white-noise ar) 0.1)))
  (audition (out 0 (ifft* (pv-phase-shift270 (fft* 10 n))))))
]


