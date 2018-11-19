#lang racket/base

(require rackunit
         "../use-directory-in.rkt")

(check-equal? a 1)
(check-equal? b 4)
(check-equal? c 8)

