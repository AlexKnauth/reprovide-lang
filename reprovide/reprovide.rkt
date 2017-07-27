#lang racket/base

(provide reprovide)

(require syntax/parse/define
         (for-syntax racket/base
                     racket/require-transform))

(begin-for-syntax
  (define-syntax-class reprov-spec
    [pattern require-spec:expr
      #:with [[local-id phase] ...]
      (let-values ([[imports import-sources] (expand-import #'require-spec)])
        (for/list ([import (in-list imports)])
          (list (import-local-id import)
                (import-mode import))))]))

(define-simple-macro (reprovide spec:reprov-spec ...)
  (begin
    (require spec.require-spec ...)
    (provide (for-meta spec.phase spec.local-id) ... ...)))
