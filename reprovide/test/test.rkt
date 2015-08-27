#lang racket/base
(require rackunit "use.rkt")
(check-equal? (first '(1 2 3)) 1)
(check-equal? (match '(1 2 3) [(list a _ _) a]) 1)
