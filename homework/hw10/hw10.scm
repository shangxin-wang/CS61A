(define (accumulate combiner start n term)
  (if (= n 0)
      0
      (if (= n 1) (combiner start (term n))
                  (accumulate combiner (combiner start (term n)) (- n 1) term)))
)

(define (accumulate-tail combiner start n term)
(if (= n 0)
    0
    (if (= n 1) (combiner start (term n))
                (accumulate combiner (combiner start (term n)) (- n 1) term)))
)

(define (rle s)
  (define (helper s i prev)
      (cond ((null? s) (cons-stream (list prev i) nil))
            ((= (car s) prev) (helper (cdr-stream s) (+ i 1) prev) )
            (else (cons-stream (list prev i)
                               (helper (cdr-stream s) 1 (car s))))))
  (if (null? s)
      nil
      (helper (cdr-stream s) 1 (car s))))
