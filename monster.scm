; ---- Monster ----
(define (monster-maker health take-damage power type)
  (if (<= health 0)
    '()
    (lambda (action . attack-instance)
      (case action
        ((get-attacked) (monster-maker (- health (take-damage (car attack-instance)))
                                        take-damage
                                        power
                                        type))
        ((attack) power)
        ((see-type) type)
        ((see-health) health)))))

(define (new-monster-maker type)
  (let ((health (health-maker type))
        (take-damage (damage-taker-maker type))
        (damage (monster-attack-maker type)))
    (monster-maker health take-damage damage type)))

(define (health-maker type)
  (case type
    ((zombie) (integer-between 50 100))
    ((vampire) (integer-between 100 200))
    ((ghoul) (integer-between 40 80))
    ((werewolf) 200)
    ((human) 100)))

(define (monster-attack-maker type)
  (case type
    ((zombie) (integer-between 0 10))
    ((vampire) (integer-between 10 20))
    ((ghoul) (integer-between 15 30))
    ((werewolf) (integer-between 0 40))
    ((human) -1)))

(define (damage-taker-maker type)
  (case type
    ((zombie)
     (lambda (attack)
       (case (attack 'type)
         ((straw) (* 2 (attack 'damage)))
         (else (attack 'damage)))))
    ((vampire)
     (lambda (attack)
       (case (attack 'type)
         ((chocolate) 0)
         (else (attack 'damage)))))
    ((ghoul)
     (lambda (attack)
       (case (attack 'type)
         ((nerd) (* 5 (attack 'damage)))
         (else (attack 'damage)))))
    ((werewolf)
     (lambda (attack)
       (case (attack 'type)
         ((chocolate) 0)
         ((straw) 0)
         (else (attack 'damage)))))
    ((human) (lambda (attack) 0))))

(define (choose-random-monster-type)
  (choose-from-list '(zombie vampire ghoul werewolf)))

(define (display-monsters house)
  (display-list (house 'monsters) display-single-monster)
  (if (> (house 'people) 0)
    (begin
      (newline)
      (display (house 'people))
      (display " people in house."))))

(define (display-single-monster monster)
  (begin
    (display (monster-name-from-type (monster 'see-type)))
    (display " Health: ")
    (display (monster 'see-health))
    (display " Attack: ")
    (display (monster 'attack))))

(define (monster-name-from-type type)
  (case type
    ((zombie) "Zombie")
    ((vampire) "Vampire")
    ((ghoul) "Ghoul")
    ((Werewolf) "Werewolf")))
