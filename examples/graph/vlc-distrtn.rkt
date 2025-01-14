#lang racket
;; status - not working as of 20220820

#|
string-append: contract violation
  expected: string?
  given: 6810
|#

(require rsc3)

;; vlc-distrtn (rd)
;; caution - audio feedback graph

(define prep
  (lambda (p)
    (let ((ampl (list-ref p 0))
          (phase (list-ref p 1)))
      (list (s:db-amp ampl) phase))))

(define vlc
  '((0.00000 1.85550)
    (-9.92383 -0.65147)
    (-8.74205 -0.74728)
    (-3.70464 -1.39796)
    (-9.43435 -1.14812)
    (-25.84790 -1.03375)
    (-16.99500 -2.41724)
    (-29.17040 2.67419)
    (-26.82750 -1.61810)
    (-18.59870 1.34568)
    (-19.72160 -2.85972)
    (-29.43650 0.54603)
    (-23.63120 -1.47813)
    (-28.20100 -1.98501)
    (-41.20700 -1.11808)
    (-33.14310 -2.19369)
    (-31.54010 1.43134)
    (-47.62740 1.28571)
    (-28.79740 -1.03754)
    (-34.97950 0.37740)
    (-39.05770 -0.57557)
    (-38.84060 2.34836)
    (-40.18090 -0.96978)
    (-47.32150 2.14768)
    (-45.49290 2.52100)
    (-40.57100 -1.39905)
    (-47.19530 -2.23994)
    (-50.80920 2.97853)
    (-48.13640 0.46815)
    (-58.56890 -1.01821)
    (-57.81200 -3.08971)
    (-47.96870 -0.48657)
    (-43.96100 -0.10311)
    (-50.49810 -2.80977)
    (-50.61640 -0.17212)
    (-60.64640 -1.02433)
    (-58.03410 1.06921)
    (-55.46390 -2.04501)
    (-54.31000 -1.53512)
    (-52.78670 -1.49875)
    (-57.99380 0.17697)
    (-56.76990 2.28241)
    (-54.17450 -1.85553)
    (-62.58220 -2.40971)
    (-59.86460 1.04782)
    (-61.58570 1.56183)
    (-52.62080 1.68360)
    (-49.82940 -1.11019)
    (-56.18160 -0.78538)
    (-57.73320 -2.23918)
    (-49.87560 3.09604)
    (-51.00100 -0.53762)
    (-59.71530 0.99017)
    (-65.73280 2.43855)
    (-73.01270 -0.90664)
    (-61.81450 -0.53346)
    (-65.58980 1.51174)
    (-75.94320 -3.06072)
    (-65.22210 -1.49937)
    (-70.79970 -2.96199)
    (-64.72450 1.78172)
    (-73.24130 0.26939)
    (-66.17110 -0.23305)
    (-61.32910 -3.12592)
    (-66.98180 0.64700)
    (-65.23060 -2.94395)
    (-70.13430 1.29805)
    (-68.43470 -1.35906)
    (-71.33000 -2.71582)
    (-86.90080 2.11646)
    (-74.97450 2.76118)
    (-68.02520 0.94979)
    (-67.32960 3.05994)
    (-67.32140 -2.79905)
    (-68.22010 -2.33831)))

(define vlc-partial
  (lambda (in freq detune fall)
    (lambda (n)
      (let* ((m (* n 2))
             (ampl (buf-rd 1 kr 0 m 0 0)))
        (mul (ringz in
                    (mul3 freq
                          (+ n 1)
                          (mul-add (lf-noise1 kr 1) detune 1.0))
                    (mul fall (rand 0.75 1.25)))
             ampl)))))

(define vlc-plyr
  (lambda (n)
    (letc ((buf    0)
           (iamp   0.1)
           (ampl   0.1)
           (freq   129.897)
           (fall   0.5)
           (loc    0.0)
           (detune 0.001))
      (let* ((i (mul (sound-in 4) iamp))
             (s (foldl1 add
                        (map (vlc-partial i freq detune fall)
                             (enum-from-to 0 (- n 1))))))
        (mrg2 (detect-silence s 0.001 0.2 remove-synth)
              (out 0 (clip2 (pan2 s loc ampl) 0.1)))))))

(define vlc-get-cps
  (lambda (b)
    (midi-cps (+ (choose b)
                 (s:degree-to-key (choose (list 0 1 2 3 4 5 6 7 8))
                                  (list 0 2 3 5 7 8 10)
                                  12)))))

(define pattern
  (lambda (fd)
    (send fd (n-set1 1002 "freq" (vlc-get-cps (list 24 36 48 60))))
    (send fd (n-set1 1002 "iamp" (rand-float 0.5 0.75)))
    (thread-sleep (choose (list 0.5 0.75 1.5 3.0)))
    (pattern fd)))

(with-sc3
 (lambda (fd)
   (async fd (b-alloc 0 (* (length vlc) 2) 1))
   (send fd (b-setn1 0 0 (flatten (map prep vlc))))
   (send-synth fd "vlc-plyr48" (vlc-plyr 48))
   (send fd (s-new "vlc-plyr48" 1002 add-to-tail 1
                   (list "buf"    0
                         "loc"    (rand-float -1 1)
                         "ampl"   (rand-float 0.05 0.1)
                         "freq"   (vlc-get-cps (list 48 55 60))
                         "detune" (rand-float 0.001 0.005)
                         "fall"   (rand-float 1 7))))
   (pattern fd)))
