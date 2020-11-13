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
