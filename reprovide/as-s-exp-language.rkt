#lang racket/base

(provide (rename-out [module-begin #%module-begin])
         (all-from-out "main.rkt"))

(require syntax/modresolve
         (except-in "main.rkt" #%module-begin)
         (for-syntax racket/base
                     syntax/parse))

;; VariableReference -> ModulePath
(define (variable-reference->module-path varref)
  (resolve-module-path-index
   (variable-reference->module-path-index varref)))

(begin-for-syntax
  (define (make-variable-reference stx)
    (datum->syntax
     stx
     `(,(datum->syntax stx '#%variable-reference stx stx))
     stx
     stx)))

(define-syntax module-begin
  (lambda (stx)
    (syntax-parse stx
      [(_ require-spec ...)
       #:with varref (make-variable-reference stx)
       #'(#%module-begin
          (reprovide require-spec ...)
          (define self-module-path
            (variable-reference->module-path varref))
          (module* self-module-path #f
            (provide self-module-path))
          (module* reader syntax/module-reader
            #:language self-module-path
            (require (submod ".." self-module-path))))])))

;; ---------------------------------------------------------

(module reader syntax/module-reader
  reprovide/as-s-exp-language)

