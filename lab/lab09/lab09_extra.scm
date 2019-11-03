;; Extra Scheme Questions ;;


; Q5
(define lst
  (list (cons 1 nil) 2 (cons 3 (cons 4 nil)) 5)
)

; Q6
(define (composed f g)
  (lambda (x) (f (g x)))
)

; Q7
(define (remove item lst)
  (cond ((null? lst) ())
        ((not (= item (car lst)))
          (cons (car lst) (remove item (cdr lst))))
        (else (remove item (cdr lst))))
)


;;; Tests
(remove 3 nil)
; expect ()
(remove 3 '(1 3 5))
; expect (1 5)
(remove 5 '(5 3 5 5 1 4 5 4))
; expect (3 1 4 4)

; Q8
(define (no-repeats s)
  (cond ((null? s) ())
        ((null? (cdr s)) s)
        ((= (car s) (car (cdr s))) )
        (else (cons (car s) (no-repeats (remove (car s) (cdr s)))
        )
)

; Q9
(define (substitute s old new)
  'YOUR-CODE-HERE
)

; Q10
(define (sub-all s olds news)
  'YOUR-CODE-HERE
)
