(define (cddr s)
  (cdr (cdr s)))

(define (cadr s)
  (car (cdr s))
)

(define (caddr s)
  (car (cddr s))
)

(define (sign x)
  (cond ((< x 0) -1)
        ((= x 0) 0)
        (else 1))
)

(define (square x) (* x x))

(define (pow b n)
  (cond ((even? n) (square (expt b (/ n 2))))
        (else (* b (square(expt b (/ (- n 1) 2))))))
)

(define (ordered? s)
  (cond ((null? s) #t)
        ((null? (cdr s)) #t)
        ((<= (car s) (cadr s)) (ordered? (cdr s)))
        (else #f))
)
