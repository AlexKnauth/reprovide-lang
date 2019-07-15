#lang racket/base

(provide combine-in*)

(require racket/require-syntax
         (for-syntax racket/base
                     syntax/parse
                     ))

(begin-for-syntax
  (define-syntax-class except-ids
    #:attributes ([id 1])
    [pattern except-id:id
             #:with [id ...] #'[except-id]]
    [pattern [id:id ...]]))

(define-require-syntax combine-in*
  (lambda (stx)
    (syntax-parse stx
      [(combine-in* require-spec:expr ...)
       (syntax/loc stx
         (combine-in* require-spec ... #:except []))]
      [(combine-in* require-spec:expr ... #:except except:except-ids)
       (syntax/loc stx
         (except-in (combine-in require-spec ...)
                    except.id ...))])))

