; weapon.scm
;
; Functions dealing with weapons. A weapon is represented as a function that
; returns information about the conceptual weapon depending on what arguments
; the function is passed.
;
; When a weapon is used, except in the case of a base weapon, the number
; of times the weapon can be used again decreases. The weapon disappears
; when it can no longer be used.
;
; Because there is no mutable state, it is necessary to have functions that
; create a new weapon when actions are taken that affect a weapon.
;
; The attacking power of a weapon and its type are determined when it is
; generated. Use count is the only attribute of a weapon that should change in
; the middle of a game instance.
;
; author: Nathaniel Bowman
; revised: November 19, 2020


(load "random.scm")
(load "helper.scm")

; ---- Weapon ----
(define (weapon-maker type count)
  (let ((damage
          (case type
            ((kiss) 1)
            ((straw) (float-between 1 1.75))
            ((chocolate) (float-between 2 2.4))
            ((nerd) (float-between 3.5 5)))))
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
            ((kiss) 100)
            ((straw) 2)
            ((chocolate) 4)
            ((nerd) 1))))
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

(define (choose-random-weapon-type)
  (choose-from-list '(kiss straw chocolate nerd)))

(define (generate-arsenal)
  (generate-list-from-types new-weapon-maker choose-random-weapon-type 10))

(define (display-arsenal state)
  (display-list (state 'weapons) display-single-weapon))

(define (display-single-weapon weapon)
  (begin
    (display (weapon-name-from-type (weapon 'type)))
    (display " Damage: ")
    (display (weapon 'damage))
    (display " Count: ")
    (display (weapon 'count))))

(define (weapon-name-from-type type)
  (case type
    ((kiss) "HersheyKiss")
    ((straw) "SourStraw")
    ((chocolate) "ChocolateBar")
    ((nerd) "NerdBomb")))
