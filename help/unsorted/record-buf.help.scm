; record-buf

; allocate buffer (assume sample-rate of 48000)
(with-sc3 (lambda (fd) (async fd (b-alloc 0 (* 48000 4) 1))))

; record for four seconds (until end of buffer)
(let ((o (mul (formant (x-line 400 1000 4 do-nothing) 2000 800) 0.125)))
  (mrg2 o (record-buf 0 0 1 0 1 no-loop 1 remove-synth o)))

; play it back
(play-buf 1 0 1 1 0 no-loop remove-synth)

; ...
(with-sc3 (lambda (fd) (async fd (b-alloc 0 (* 48000 4) 1))))

(define recorder
  (letc ((bus 0)
         (bufnum 0)
         (offset 1)
         (recLevel 1)
         (preLevel 0)
         (run 1)
         (loop 1)
         (trigger 1))
    (let ((i (in 2 (add num-output-buses bus))))
      (record-buf bufnum offset recLevel preLevel run loop trigger do-nothing i))))

(define player
  (letc ((bufnum 0)
         (rate 1)
         (trigger 1)
         (startPos 0)
         (loop 1)
         (gain 1))
    (out 0 (mul (play-buf 2 bufnum rate trigger startPos loop do-nothing) gain))))

(with-sc3
 (lambda (fd)
   (send-synth fd "recorder" recorder)
   (let ((b 10)
	 (y 1001)
	 (z 1002))
     (async fd (b-alloc b 44100 2))
     (send fd (s-new2 "recorder" y add-to-tail 1 "bufnum" b "bus" 0))
     (send fd (n-trace y))
     (send-synth fd "player" player)
     (send fd (s-new1 "player" z add-to-tail 1 "bufnum" b)))))

(define do-send
  (lambda (m)
    (with-sc3
     (lambda (fd)
       (send fd m)))))

(do-send (n-set1 1001 "run" 1))

(do-send (n-set1 1002 "loop" 1))
(do-send (n-set1 1002 "gain" 2))
(do-send (n-set1 1002 "trigger" 1))

(do-send (n-free1 1001))
(do-send (n-free1 1002))

(with-sc3
 (lambda (fd)
   (async fd (b-free 10))))
