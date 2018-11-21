#lang racket/base

(require "../use-glob-in.rkt")
(module+ test
  (require rackunit))

(module+ test
  (check-equal? a 1)
  (check-equal? b 4)
  (check-equal? c 8)
  )
