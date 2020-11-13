; ---- Player ----
(define (player-maker health power)
  (if (<= health 0)
    '()
    (lambda (action . damage-or-weapon)
      (case action
        ((get-attacked) (player-maker (- health damage-or-weapon) power))
        ((attack) (* power damage-or-weapon))))))

(define (player-get-attacked player house)
  (player 'get-attacked
          (if (> (length (house 'monsters)) 0)
            ((car (house 'monsters)) 'attack)
            ((car (house 'people)) 'attack))))
