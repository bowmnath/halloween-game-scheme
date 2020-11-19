; player.scm
;
; Functions dealing with the Player. The Player is represented as a function
; that
;   * returns information about the conceptual player depending on what
;     arguments the function is passed, or
;   * returns a new player resulting from an attack, or
;   * returns an attack corresponding to the power of the player and the
;     weapon choice.
;
; Because there is no mutable state, it is necessary to have functions that
; create a new player when actions are taken that affect a player.
;
; The attacking power of a player is determined when it is generated. Health is
; the only attribute of a player that should change in the middle of a game
; instance.
;
; author: Nathaniel Bowman
; revised: November 19, 2020


; ---- Player ----
(define (player-maker health power)
  (if (<= health 0)
    '()
    (lambda (action damage-or-weapon)
      (case action
        ((get-attacked) (player-maker (- health damage-or-weapon) power))
        ((attack) (attack-maker (new-weapon-maker damage-or-weapon) power))
        ((see-attack) power)
        ((see-health) health)))))

(define (new-player-maker)
  (player-maker (integer-between 100 125) (integer-between 10 20)))

(define (player-get-attacked player house)
  (player 'get-attacked
          (if (> (length (house 'monsters)) 0)
            ((choose-random-monster house) 'attack)
            (if (> (house 'people) 0)
              ((new-monster-maker 'human) 'attack)
              0))))
