; random.scm
;
; Helper routines for dealing generating random numbers. Included in a
; separate file because they generic enough to be reused in various Zork
; files (and conceivably other projects).
;
; author: Nathaniel Bowman
; revised: November 19, 2020


; Integer between a and b *inclusive*
(define (integer-between a b)
  (+ (random (+ (- b a) 1)) a))

; Floating-point number between a and b. Inclusive vs exclusive should not
; matter when dealing with floating-point numbers.
(define (float-between a b)
  (+ (* (flo:random-unit default-random-source) (- b a)) a))
