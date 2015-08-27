#lang racket/base

(provide reprovide)

(require (for-syntax racket/base
                     racket/list
                     racket/require-transform
                     syntax/parse))

(define-syntax reprovide
  (syntax-parser
    [(reprovide require-spec ...)
     #:with [[[local-id phase] ...] ...]
     (for/list ([require-spec (in-list (syntax->list #'(require-spec ...)))])
       (define-values [imports import-sources]
         (expand-import require-spec))
       (for/list ([import (in-list imports)])
         (list (import-local-id import)
               (import-mode import))))
     #'(begin
         (require require-spec ...)
         (provide (for-meta phase local-id) ... ...))]))
