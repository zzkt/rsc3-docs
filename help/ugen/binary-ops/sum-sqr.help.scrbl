#lang scribble/manual
@(require (for-label racket))

@title{(sum-sqr a b)}


Return the value of (a*a) + (b*b). This is more efficient than
using separate unit generators for each operation.


@racketblock[
(audition
 (out 0 (mul (sum-sqr (f-sin-osc ar 800 0) 
		      (f-sin-osc ar (x-line kr 200 500 5 do-nothing) 0)) 
	     0.125)))
]


@racketblock[
(let ((a (f-sin-osc ar 800 0))
      (b (f-sin-osc ar (x-line kr 200 500 5 do-nothing) 0)))
  (audition
   (out 0 (mul (add (mul a a) (mul b b)) 0.125))))
]


