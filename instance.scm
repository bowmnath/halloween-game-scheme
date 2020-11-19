; instance.scm
;
; This is the game driver, or "main" function. To run an instance of Zork,
; call `mit-scheme --quiet < instance.scm`.
;
; Running a game requires an initial state, an example of which is specified
; below as `start-state`. The start state is random and will change every
; time the game is run.
;
; The location of houses in the neighborhood is fixed. To modify the
; neighborhood layout, you would update the second argument to `state-maker`.
; If houses are added or removed, update the third argument to `state-maker`
; accordingly by adding or removing calls to `new-house-maker`.
;
; Because there is no user interaction, the game accepts a predefined list of
; actions to take on behalf of the user. Filling the list of actions requires
; a little bit of guesswork because the weapons are not known ahead of time.
; It would be simple enough to allow attacking with a random weapon instead,
; but that has not been implemented.
;
; author: Nathaniel Bowman
; revised: November 19, 2020


(load "game.scm")
(load "player.scm")
(load "monster.scm")
(load "house.scm")
(load "location.scm")

; Neighborhood map
; Technically, nothing stops the player from leaving the neighborhood
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
