(define (choose-from-list options)
  ; does not check for empty list
  (let random-helper ((num-skip (integer-between 0 (- (length options) 1)))
                      (new-options options))
    (if (> num-skip 0)
      (random-helper (- num-skip 1) (cdr new-options))
      (car new-options))))
