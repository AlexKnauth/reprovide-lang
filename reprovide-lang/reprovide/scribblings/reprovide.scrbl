#lang scribble/manual

@(require (for-label reprovide reprovide/reprovide (only-in racket/base require provide)))

@title{reprovide-lang}

@section{@hash-lang[] @racketmodname[reprovide]}

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

@section{Extra @racket[require] forms}

@subsection{Require with fallbacks}

@defmodule[reprovide/require-transformer/combine-in-fallback]

These forms are provided by both
@hash-lang[] @racketmodname[reprovide] and
@racketmodname[reprovide/require-transformer/combine-in-fallback].

@defform[(combine-in/fallback require-spec ...)]{
The union of the @racket[require-spec]s, where imports not in the
first ones can "fall back" on imports in subsequent ones.

Like @racket[(combine-in require-spec ...)], but more lenient when
imports from the @racket[require-spec]s have the same identifier name:
the first ones take precedence over the subsequent ones.
}

@defform[(allow-in require-spec id-maybe-renamed ...)
         #:grammar [(id-maybe-renamed id
                                      [orig-id bind-id])]]{
Like @racket[(only-in require-spec id-maybe-renamed ...)], but more
lenient when @racket[id] or @racket[orig] isn't in the
@racket[require-spec].
}

These can be used together to import an identifier if it exists, but
fall back on a different identifier otherwise:
@racketblock0[
  (require (combine-in/fallback
            (allow-in racket/unsafe/ops
                      [unsafe-f32vector-set! unsafe?-f32vector-set!])
            (allow-in ffi/vector
                      [f32vector-set! unsafe?-f32vector-set!])))
]

@subsection{Require by glob}

@defmodule[reprovide/require-transformer/glob-in]

These forms are provided by both
@hash-lang[] @racketmodname[reprovide] and
@racketmodname[reprovide/require-transformer/glob-in].

@defform[(glob-in glob-str ...)]{

Examples:
@nested[#:style 'code-inset]{
  @racketblock0[(require (glob-in "directory/*.rkt"))]
  requires every file ending in @litchar{.rkt} in the given directory.
}

@nested[#:style 'code-inset]{
  @racketblock0[(require (glob-in "directory/*.{rkt,scrbl}"))]
  requires every file ending in @litchar{.rkt} or @litchar{.scrbl} in
  the given directory.
}

@nested[#:style 'code-inset]{
  @racketblock0[(require (glob-in "{linear,affine}/{data,transformation,decomposition}.rkt"))]
  requires six things, according to every combination of options:
  @itemize[
    @item{@litchar{linear/data.rkt}}
    @item{@litchar{linear/transformation.rkt}}
    @item{@litchar{linear/decomposition.rkt}}
    @item{@litchar{affine/data.rkt}}
    @item{@litchar{affine/transformation.rkt}}
    @item{@litchar{affine/decomposition.rkt}}
  ]
}

The syntax for each @racket[glob-str] is described in
@secref["glob" #:doc '(lib "file/scribblings/file.scrbl")].

}

