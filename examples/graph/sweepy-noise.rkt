#lang racket
;; status - working as of 20220820

(require rsc3)

;; sweepy noise (jmcc)

(define sn
  (let* ((n (clone 2 (white-noise ar)))
         (lfo-depth (mouse-y kr 200 8000 1 0.2))
         (lfo-rate (mouse-x kr 4 60 1 0.2))
         (freq (mul-add (lf-saw kr lfo-rate 0)
                        lfo-depth
                        (mul lfo-depth 1.2)))
         (filtered (rlpf (mul n 0.03) freq 0.1)))
    (add (comb-n filtered 0.3 0.3 2) filtered)))

(audition (out 0 sn))
