; ---- Weapon ----
(define (weapon-maker type count)
  (let ((damage
          (case type
            ((kiss) 1)
            ((nerd) 4)
            (else 5))))
    (if (= 0 count)
      '()
      (lambda (arg)
        (case arg
          ((type) type)
          ((count) count)
          (else damage))))))

(define (new-weapon-maker type)
  (let ((count
          (case type
            ((kiss) 2)
            ((nerd) 3)
            (else 100))))
    (weapon-maker type count)))

(define (use-weapon weapon)
  (let ((type (weapon 'type)))
    (if (equal? type 'kiss)
      weapon
      (weapon-maker type (- (weapon 'count) 1)))))

(define (update-weapon-inventory weapons choice)
  (if (null? weapons)
    (error "You do not have that weapon")
    (if (equal? ((car weapons) 'type) choice)
      (let ((new-weapon (use-weapon (car weapons))))
        (if (null? new-weapon)
          (cdr weapons)
          (append (list new-weapon) (cdr weapons))))
      (append (list (car weapons)) (update-weapon-inventory (cdr weapons) choice)))))

(define (attack-maker weapon power)
  (lambda (arg)
    (case arg
      ((type) (weapon 'type))
      (else (* power (weapon 'damage))))))
