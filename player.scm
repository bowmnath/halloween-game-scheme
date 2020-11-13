; ---- Player ----
(define (player-maker health power)
  (if (<= health 0)
    '()
    (lambda (action damage-or-weapon)
      (case action
        ((get-attacked) (player-maker (- health damage-or-weapon) power))
        ((attack) (attack-maker (weapon-maker damage-or-weapon) power))))))

(define (player-get-attacked player house)
  (player 'get-attacked
          (if (> (length (house 'monsters)) 0)
            ((car (house 'monsters)) 'attack)
            ((new-monster-maker 'human) 'attack))))
