#lang reprovide/test/example-lang/example-lang

(module+ test
  (require rackunit))

(define (f x)
  (match (first x)
    [(list a b c)
     (third b)]))

(module+ test
  (check-equal? (f (list (list 'a (list 'b 2 3) 'c)))
                3))

