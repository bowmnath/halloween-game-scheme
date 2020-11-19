; house.scm
;
; Functions dealing with houses. A house is represented as a function that
; returns information about the conceptual house depending on what arguments
; the function is passed.
;
; Because there is no mutable state, it is necessary to have functions that
; create a new house when actions are taken that affect a house.
;
; author: Nathaniel Bowman
; revised: November 19, 2020


(load "helper.scm")

; ---- House ----
(define (house-get-attacked house attack)
  (let ((monsters (map (lambda (m) (m 'get-attacked attack)) (house 'monsters))))
    (let ((live-monsters (filter (lambda (x) (not (null? x))) monsters)))
      (let ((new-people
              (+ (house 'people)
                 (- (length (house 'monsters)) (length live-monsters)))))
        (list (house-maker live-monsters new-people))))))

(define (houses-after-attack house attack houses)
  (let house-rec ((houses houses) (new-houses '()))
    (if (eq? (car houses) house)
      (append new-houses (house-get-attacked house attack) (cdr houses))
      (house-rec (cdr houses) (append new-houses (list (car houses)))))))

(define (house-maker monsters people)
  (lambda (value)
    (case value
      ((monsters) monsters)
      ((people) people))))

(define (new-house-maker)
  (house-maker (generate-house-monsters) 0))

(define (num-monster-get house)
    (length (house 'monsters)))

(define (choose-random-monster house)
  (choose-from-list (house 'monsters)))

(define (generate-house-monsters)
  (let ((num-monsters-in-house (integer-between 0 10)))
    (generate-list-from-types
      new-monster-maker
      choose-random-monster-type
      num-monsters-in-house)))
