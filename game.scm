(load "state.scm")

; ---- Game ----
; don't have input capability right now, so game is just list of moves
(define (game state moves)
  (if (null? (state 'player))
    (begin
      (display "Oh no! You did not save the neighborhood!")
      (newline)
      #f)
    (if (= (state 'num-monsters) 0)
      (begin
        (display "Everyone is back to normal! Great work!")
        (newline)
        #t)
      (if (= (length moves) 0)
        (error "Ran out of moves before game completed")
        (begin
          (display-state state)
          (game (next-state state (car moves)) (cdr moves)))))))
