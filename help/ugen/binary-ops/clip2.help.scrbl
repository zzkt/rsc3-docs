#lang scribble/manual
@(require (for-label racket))

@title{(clip2 a b)}


Bilateral clipping.  clips a to +/- b


@racketblock[
(audition
 (out 0 (clip2 (f-sin-osc ar 400 0) 0.2)))
]


@racketblock[
(audition
 (out 0 (clip2 (f-sin-osc ar 400 0) (line kr 0 1 8 remove-synth))))
]


