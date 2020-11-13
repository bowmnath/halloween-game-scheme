; ---- House ----
(define (house-get-attacked house attack)
  (let ((monsters (map (lambda (m) (m 'get-attacked attack)) (house 'monsters))))
    (let ((live-monsters (filter (lambda (x) (not (null? x))) monsters)))
      (let ((new-people (+ (house 'people) (- (house 'monsters) live-monsters))))
        (house-maker live-monsters new-people)))))

(define (house-maker monsters people)
  (lambda (value)
    (case (value)
      (('monsters) monsters)
      (('people) people))))

(define (num-monster-get house)
    (length (house 'monsters)))
