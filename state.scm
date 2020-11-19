; state.scm
;
; Functions dealing with game state. State is represented as a function that
; returns other functions relating to the player, houses, weapons, and any
; other aspects of game state that need to be recorded. The game progresses
; by moving from one state to the next.
;
; Because nothing is mutable, it is necessary to have functions that create a
; new state whenever state must be updated.
;
; author: Nathaniel Bowman
; revised: November 19, 2020


(load "weapon.scm")
(load "monster.scm")

; ---- State ----
(define (state-maker location house-locations houses player weapons)
  (lambda (value)
    (case value
      ((location) location)
      ((house-locations) house-locations)
      ((houses) houses)
      ((weapons) weapons)
      ((num-monsters) (reduce + 0 (map num-monster-get houses)))
      ((player) player))))

(define (next-state state action)
  (let ((location (next-location state action))
        (houses (next-houses state action)))
    (let ((player (next-player state houses action))
          (weapons (next-weapons state action)))
      (state-maker location (state 'house-locations) houses player weapons))))

(define (next-location state action)
  (if (equal? (car action) 'move)
    (do-move (state 'location) (move-maker (cadr action)))
    (state 'location)))

(define (next-houses state action)
  (if (equal? (car action) 'attack)
    (let ((house (get-house-at-location state (state 'houses)))
          (attack-instance ((state 'player) 'attack (cadr action))))
      (if (null? house)
        (error "No house to attack!")
        (houses-after-attack house attack-instance (state 'houses))))
    (state 'houses)))

(define (next-player state houses action)
  (if (equal? (car action) 'attack)
    (let ((house (get-house-at-location state houses)))
      (player-get-attacked (state 'player) house))
    (state 'player)))

(define (next-weapons state action)
  (if (equal? (car action) 'attack)
    (update-weapon-inventory (state 'weapons) (cadr action))
    (state 'weapons)))

(define (get-house-at-location state houses)
  (let ((current-location (location-list (state 'location))))
    (let rec-match-house ((locations (state 'house-locations))
                          (houses houses))
      (if (null? locations)
        '()
        (if (equal? current-location (location-list (car locations)))
          (car houses)
          (rec-match-house (cdr locations) (cdr houses)))))))

(define (display-state state)
  (begin
    (newline)
    (let ((loc (state 'location)))
      (display "Location: ")
      (display (loc 'x))
      (display " ")
      (display (loc 'y)))
    (newline)
    (display "Health: ")
    (display ((state 'player) 'see-health 0))
    (newline)
    (display "Arsenal: ")
    (newline)
    (display-arsenal state)
    (newline)
    (display "Total monsters remaining: ")
    (display (state 'num-monsters))
    (newline)
    (let ((current-house (get-house-at-location state (state 'houses))))
      (if (not (null? current-house))
        (begin
          (display "Monsters at current location: ")
          (newline)
          (display-monsters current-house))))
    (newline)
    (newline)
    (newline)))
