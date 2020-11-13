; ---- Weapon ----
; TODO don't have count yet
(define (weapon-maker type)
  (let ((damage
          (case type
            ((kiss) 1)
            ((nerd) 4)
            (else 5))))
    (lambda (arg)
      (case arg
        ((type) type)
        (else damage)))))

(define (attack weapon player)
  (lambda (arg)
    (case arg
      ((type) (weapon 'type))
      (else (* (player 'power) (weapon 'damage))))))
