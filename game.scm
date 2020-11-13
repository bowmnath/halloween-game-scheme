(load "state.scm")

; ---- Game ----
; don't have input capability right now, so game is just list of moves
(define (game state moves)
  (if (null? (state 'player))
    #f
    (if (= (state 'num-monsters) 0)
      #t
      (if (= (length moves) 0)
        (error "Ran out of moves before game completed")
        (game (next-state state (car moves)) (cdr moves))))))
