#lang racket/base

(provide glob-in)

(require racket/require-syntax
         (for-syntax
          racket/base
          racket/syntax
          racket/require-transform
          file/glob
          syntax/parse
          lang-file/read-lang-file
          "private/this-expression-source-file.rkt"))

(begin-for-syntax
  (define (path-of p)
    (let-values ([(base name dir?) (split-path p)])
      base)))

(define-require-syntax glob-in
  (lambda (stx)
    (syntax-parse stx
      [(glob-in glob-str:str ...)
       #:do [(define stx-pth
               (path-of
                (syntax-local-eval
                 (datum->syntax
                  stx
                  `(,#'this-expression-source-file)
                  stx))))]
       #:with [file-spec ...]
       ; The `in-glob` sequence goes by current-directory
       (parameterize ([current-directory stx-pth])
         (for*/list ([glob-str (in-list (syntax->list #'[glob-str ...]))]
                     [glob-file (in-glob (syntax-e glob-str))]
                     #:when (lang-file? glob-file))
           (datum->syntax
            glob-str
            `(,#'file
              ,(datum->syntax glob-str (path->string glob-file) glob-str))
            glob-str)))
       (syntax/loc stx
         (combine-in file-spec ...))])))

