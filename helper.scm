; helper.scm
;
; Helper routines for dealing with lists. Included in a separate file because
; they generic enough to be reused in various Zork files (and conceivably
; other projects).
;
; author: Nathaniel Bowman
; revised: November 19, 2020


(define (choose-from-list options)
  ; does not check for empty list
  (let random-helper ((num-skip (integer-between 0 (- (length options) 1)))
                      (new-options options))
    (if (> num-skip 0)
      (random-helper (- num-skip 1) (cdr new-options))
      (car new-options))))


(define (generate-list-from-types element-maker type-chooser number)
  (let list-helper ((num-left number)
                    (so-far '()))
    (if (= 0 num-left)
      so-far
      (let ((new-element (element-maker (type-chooser))))
        (list-helper (- num-left 1) (append so-far (list new-element)))))))


(define (display-list total-list display-item)
  (let rec-display ((remaining total-list))
    (if (not (null? remaining))
      (begin
        (display-item (car remaining))
        (newline)
        (rec-display (cdr remaining))))))
