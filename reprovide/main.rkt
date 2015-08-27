#lang racket/base

(provide (rename-out [-#%module-begin #%module-begin])
         #%datum
         submod
         lib
         file
         planet
         only-in
         except-in
         prefix-in
         rename-in
         combine-in
         relative-in
         only-meta-in
         for-syntax
         for-template
         for-label
         for-meta
         )

(require "reprovide.rkt")

(define-syntax-rule (-#%module-begin require-spec ...)
  (#%module-begin (reprovide require-spec ...)))
