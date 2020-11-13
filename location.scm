; ---- Location ----
(define (do-move location move)
  (location-maker (+ (location 'x) (move 'x)) (+ (location 'y) (move 'y))))

(define (location-maker x y)
  (lambda (coord)
    (if (equal? coord 'x)
      x
      y)))

(define (move-maker dir)
  (case dir
    ((N) (location-maker -1 0))
    ((S) (location-maker 1 0))
    ((E) (location-maker 0 1))
    ((W) (location-maker 0 -1))))
