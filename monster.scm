; ---- Monster ----
(define (monster-maker health take-damage power)
  (if (<= health 0)
    '()
    (lambda (action . attack)
      (case action
        (('get-attacked) (monster-maker (- health (take-damage attack))
                                        take-damage
                                        power))
        (('attack) power)))))

(define (new-monster-maker type)
  (let ((health (health-maker type))
        (take-damage (damage-taker-maker type))
        (damage (attack-maker type)))
    (monster-maker health take-damage damage)))

(define (health-maker type)
  (case type
    (('vampire) 130)  ; LATER could make these functions with random numbers
    (('werewolf) 80)
    (('human) 5)
    (else 50)))

(define (attack-maker type)
  (case type
    (('vampire) 30)  ; LATER could make these functions with random numbers
    (('werewolf) 40)
    (('human) -1)
    (else 10)))

(define (damage-taker-maker type)
  (case type
    (('vampire)
     (lambda (attack)
       (case (attack 'type)  ; LATER could abstract out boilerplate,
                             ; maybe with list of exceptions as (type, damage) pairs?
         (('kiss) 0)
         (else (attack 'damage)))))
    (('werewolf)
     (lambda (attack)
       (case (attack 'type)
         (('kiss) (* 2 (attack 'damage)))
         (('nerd) (* 0.5 (attack 'damage)))
         (else (attack 'damage)))))
    (('human) (lambda (attack) 0))
    (else (lambda (attack) (attack 'damage)))))
