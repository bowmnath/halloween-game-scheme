(define (integer-between a b)
  (+ (random (+ (- b a) 1)) a))

(define (float-between a b)
  (+ (* (flo:random-unit default-random-source) (- b a)) a))
