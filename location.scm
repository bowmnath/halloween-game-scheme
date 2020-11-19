; location.scm
;
; Functions dealing with locations. A location is represented as a function
; that returns an x or y coordinate depending on its argument.
;
; Because there is no mutable state, it is necessary to have functions that
; create a new location whenever anything moves.
;
; author: Nathaniel Bowman
; revised: November 19, 2020


; ---- Location ----
(define (do-move location move)
  (location-maker (+ (location 'x) (move 'x)) (+ (location 'y) (move 'y))))

(define (location-maker x y)
  (lambda (coord)
    (if (equal? coord 'x)
      x
      y)))

(define (location-list location)
  (list (location 'x) (location 'y)))

(define (move-maker dir)
  (case dir
    ((N) (location-maker -1 0))
    ((S) (location-maker 1 0))
    ((E) (location-maker 0 1))
    ((W) (location-maker 0 -1))))
