#lang scribble/manual

@(require (for-label reprovide reprovide/reprovide (only-in racket/base require provide)))

@title{reprovide-lang}

@section{#lang reprovide}

@defmodule[reprovide #:lang]{
A @hash-lang[] language for reproviding modules.

For example, a module that reprovided @racketmodname[racket/match] and
@racketmodname[racket/list] at runtime, and provided @racketmodname[racket/base]
and @racketmodname[syntax/parse] @racket[for-syntax] would look like this:
@codeblock{
#lang reprovide
racket/match
racket/list
(for-syntax racket/base
            syntax/parse)
}}

@defform[(#%module-begin require-spec ...)]{
Expands to the form @racket[(reprovide require-spec ...)] within
@racketmodname[racket/base]'s @racketidfont{#%module-begin} form.
}

@section{reprovide as a macro}

@defmodule[reprovide/reprovide]{
This module provides @racket[reprovide] as a macro.
}

@defform[(reprovide require-spec ...)]{
This form @racket[require]s each @racket[require-spec] and @racket[provide]s
everything imported from all of them.
}

