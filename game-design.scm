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

; ---- Game ----
; don't have input capability right now, so game is just list of moves

(define (game state moves)
  (if (= (null? (state 'player)))
    #f
    (if (= (state 'num-monsters) 0)
      #t
      (if (= (length moves) 0)
        -1      ; ran out of steps
        (game (nextstate state (car moves)), (cdr moves))))))

; ---- State ----
(define (state-maker location house-locations houses player)
  (lambda (value)
    (case (value)
      (('location) location)
      (('house-locations) house-locations)
      (('num-monsters) (reduce + (map num-monster-get houses))
      (('player) player))))

(define (next-state state action)
  (let ((location (next-location state action))
        (houses (next-houses state action)))
    (let ((player (next-player state houses action)))
      (state-maker location houses player))))

(define (next-location state action)
  (if (equal? (car action) 'move)
    (do-move (state 'location) (move-maker (cadr action)))
    (state 'location)))

(define (next-houses state action)
  (if (equal? (car action) 'attack)
    (let ((house (get-house-at-location state (state 'houses))))
      (if (null? house)
        (error "No house to attack!")
        (house-get-attacked house (attack (state 'player) (cadr action)))))
    (state 'houses)))

(define (next-player state houses action)
  (if (equal? (car action) 'attack)
    (let ((house (get-house-at-location state houses)))
      (player-get-attacked (state 'player) house))
    (state 'player)))

(define (get-house-at-location state houses)
  (let rec-match-house ((locations (state 'house-locations))
                        (houses houses))
    (if (null? locations)
      '()
      (if (equal? (state 'location) (car locations))
        (car houses)
        (rec-match-house (cdr locations) (cdr houses))))))

; ---- Location ----
(define (do-move location move)
  (location-maker (+ location('x') move('x')) (+ location('y')  move('y'))))

(define (location-maker x y)
  (lambda (coord)
    (if (equal? coord 'x')
      x
      y)))

(define (move-maker dir)
  (case dir
    (('N) (location-maker 0 1))
    (('S) (location-maker 0 -1))
    (('E) (location-maker 1 0))
    (('W) (location-maker -1 0))))

; ---- House ----
(define (house-get-attacked house attack)
  (let ((monsters (map (lambda (m) (m 'get-attacked attack)) (house 'monsters))))
    (let ((live-monsters (filter (lambda (x) (not (null? x))) monsters)))
      (let ((new-people (+ (house 'people) (- (house 'monsters) live-monsters))))
        (house-maker live-monsters new-people)))))

(define (house-maker monsters people)
  (lambda (value)
    (case (value)
      (('monsters) monsters)
      (('people) people))))

(define (num-monster-get house)
    (length (house 'monsters)))

; ---- Player ----
(define (player-maker health power)
  (if (<= health 0)
    '()
    (lambda (action . damage-or-weapon)
      (case (action)
        (('get-attacked) (player-maker (- health damage-or-weapon) power))
        (('attack) (* power damage-or-weapon)))))

(define (player-get-attacked player house)
  (player 'get-attacked
          (if (> (length (house 'monsters)) 0)
            ((car (house 'monsters)) 'attack)
            ((car (house 'people)) 'attack))))

; ---- Monster ----
(define (monster-maker health take-damage power)
  (if (<= health 0)
    '()
    (lambda (action . attack)
      (case (action)
        (('get-attacked) (monster-maker (- health (take-damage attack))
                                        take-damage
                                        power))
        (('attack) power)))))

(define (new-monster-maker type)
  (let ((health (health-maker type))
        (take-damage (damage-taker-maker type))
        (damage (damage-maker type)))
    (monster-maker health take-damage damage)))

(define (health-maker type)
  (case (type)
    (('vampire) 130)  ; LATER could make these functions with random numbers
    (('werewolf) 80)
    (('human) 5)
    (else 50)))

(define (attack-maker type)
  (case (type)
    (('vampire) 30)  ; LATER could make these functions with random numbers
    (('werewolf) 40)
    (('human) -1)
    (else 10)))

(define (damage-taker-maker type)
  (case (type)
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

; ---- Weapon ----
; TODO don't have count yet
(define (weapon-maker type)
  (let ((damage
          (case (type)
            (('kiss') 1)
            (('nerd') 4)
            (else 5))))
    (lambda (arg)
      (case (arg)
        (('type) type)
        (else damage)))))

(define (attack weapon player)
  (lambda (arg)
    (case (arg)
      (('type) (weapon 'type))
      (else (* (player 'power) (weapon 'damage))))))
