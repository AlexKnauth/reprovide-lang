#lang racket/base

(provide (rename-out [-#%module-begin #%module-begin])
         #%datum
         submod
         lib
         file
         planet
         )

(require "reprovide.rkt")

(define-syntax-rule (-#%module-begin mod-path ...)
  (#%module-begin (reprovide mod-path ...)))
