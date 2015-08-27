#lang racket/base
(module+ test
  (require rackunit "use.rkt")
  (check-equal? (first '(1 2 3)) 1)
  (check-equal? (match '(1 2 3) [(list a _ _) a]) 1)
  (define-syntax m
    (lambda (stx)
      (syntax-parse stx
        [_ #'5])))
  (check-equal? (m) 5)
  )
