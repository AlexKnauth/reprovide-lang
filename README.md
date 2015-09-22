reprovide-lang
===
a racket language for reproviding modules

documentation: http://pkg-build.racket-lang.org/doc/reprovide/index.html

As a `#lang`:
```racket
#lang reprovide
require-spec
...
```
As a library:
```racket
(require reprovide/reprovide)
(reprovide require-spec ...)
```
