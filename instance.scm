; . . H
; H . .
; . . .

(define start-state
  (state-maker
    (location-maker 0 0)
    (list
      (location-maker 0 2)
      (location-maker 1 0))
    (list
      (house-maker
        (list (new-monster-maker 'vampire))
        0)
      (house-maker
        (list
          (new-monster-maker 'vampire)
          (new-monster-maker 'werewolf))
        0))
    (player-maker 100 100)))

(define moves
  (list
    (list 'move 'S)
    (list 'move 'S)
    (list 'move 'N)
    (list 'attack 'kiss)))

(game start-state moves)
