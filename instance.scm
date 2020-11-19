(load "game.scm")
(load "player.scm")
(load "monster.scm")
(load "house.scm")
(load "location.scm")

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
      (new-house-maker)
      (new-house-maker))
    (new-player-maker)
    (generate-arsenal)))

(define moves
  (list
    (list 'move 'S)
    (list 'move 'S)
    (list 'move 'N)
    (list 'attack 'nerd)
    (list 'attack 'nerd)
    (list 'attack 'kiss)
    (list 'attack 'kiss)
    (list 'attack 'kiss)
    (list 'attack 'kiss)
    (list 'attack 'kiss)
    (list 'attack 'kiss)
    (list 'attack 'kiss)
    (list 'attack 'kiss)
    (list 'attack 'kiss)
    (list 'attack 'kiss)
    (list 'attack 'kiss)
    (list 'attack 'kiss)
    (list 'attack 'kiss)
    (list 'attack 'kiss)
    (list 'attack 'kiss)
    (list 'move 'E)
    (list 'move 'E)
    (list 'move 'N)
    (list 'attack 'kiss)
    (list 'attack 'kiss)
    (list 'attack 'kiss)
    (list 'attack 'kiss)
    (list 'attack 'kiss)
    (list 'attack 'kiss)
    (list 'attack 'kiss)
    (list 'attack 'kiss)
    (list 'attack 'kiss)
    (list 'attack 'kiss)
    (list 'attack 'kiss)
    (list 'attack 'kiss)))

(game start-state moves)
