; ---- Player ----
(define (player-maker health power)
  (if (<= health 0)
    '()
    (lambda (action damage-or-weapon)
      (case action
        ((get-attacked) (player-maker (- health damage-or-weapon) power))
        ((attack) (attack-maker (new-weapon-maker damage-or-weapon) power))))))

(define (new-player-maker)
  (player-maker (integer-between 100 125) (integer-between 10 20)))

(define (player-get-attacked player house)
  (player 'get-attacked
          (if (> (length (house 'monsters)) 0)
            ((choose-random-monster house) 'attack)
            ((new-monster-maker 'human) 'attack))))
