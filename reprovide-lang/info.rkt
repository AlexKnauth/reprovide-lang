#lang info

(define collection 'multi)

(define implies
  '("reprovide-lang-lib"
    ))

(define deps
  '("base"
    "reprovide-lang-lib"
    ))

(define build-deps
  '("rackunit-lib"
    "scribble-lib"
    "racket-doc"
    ))
