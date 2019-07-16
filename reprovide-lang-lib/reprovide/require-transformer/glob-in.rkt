#lang racket/base

(provide glob-in)

(require racket/require-syntax
         (for-syntax racket/base))

(define-require-syntax glob-in
  (lambda (stx)
    (raise-syntax-error #f
      "globs only supported on Racket versions 6.7 and later"
      stx)))

