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

(define (num-monster-get house)
    (length (house 'monsters)))

(define (choose-random-monster house)
  (choose-from-list (house 'monsters)))
