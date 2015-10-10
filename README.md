reprovide-lang [![Build Status](https://travis-ci.org/AlexKnauth/reprovide-lang.png?branch=master)](https://travis-ci.org/AlexKnauth/reprovide-lang)
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
