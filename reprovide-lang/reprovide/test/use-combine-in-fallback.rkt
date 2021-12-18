#lang reprovide
(combine-in/fallback
 (allow-in racket/base [not-provided-from-racket-base list-first] [map list-map])
 (allow-in racket/list not-provided-from-racket-list [first list-first]))
