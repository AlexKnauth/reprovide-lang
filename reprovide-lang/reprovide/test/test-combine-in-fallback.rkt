#lang racket/base
(module+ test
  (require rackunit "use-combine-in-fallback.rkt"
           (for-syntax racket/base syntax/parse))
  (check-equal? (list-first '(1 2 3)) 1)
  (check-equal? (list-map add1 '(1 2 3)) '(2 3 4))
  (define-syntax undefined?
    (lambda (stx)
      (syntax-parse stx
        [(undefined? id:id)
         (if (identifier-binding #'id) #'#false #'#true)])))
  (check-false (undefined? list-first))
  (check-false (undefined? list-map))
  (check-true (undefined? not-provided-from-racket-list))
  )
