#lang racket/base
(module+ test
  (require rackunit "use-combine-in-except.rkt")
  (check-equal? (first '(1 2 3)) 1)
  (check-equal? (second '(1 2 3)) 2)
  (check-equal? (match '(1 2 3) [(list a _ _) a]) 1)
  (define-syntax m
    (lambda (stx)
      (syntax-parse stx
        [_ #'5])))
  (check-equal? (m) 5)
  (define-syntax undefined?
    (lambda (stx)
      (syntax-parse stx
        [(undefined? id:id)
         (if (identifier-binding #'id) #'#false #'#true)])))
  (check-false (undefined? first))
  (check-false (undefined? second))
  (check-true (undefined? third))
  (check-true (undefined? fourth))
  )
