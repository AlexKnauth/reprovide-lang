#lang racket/base

(provide directory-in)

(require racket/require-syntax
         (for-syntax
          racket/base
          racket/syntax
          racket/require-transform
          syntax/parse
          lang-file/read-lang-file
          "private/this-expression-source-file.rkt"))

(begin-for-syntax
  (define-syntax-class path-str
    [pattern path-str #:when (path-string? (syntax-e #'path-str))])

  (define (path-of p)
    (let-values ([(base name dir?) (split-path p)])
      base)))

(define-require-syntax directory-in
  (lambda (stx)
    (syntax-parse stx
      [(directory-in directory-path:path-str ...)
       #:do [(define stx-pth
               (path-of
                (syntax-local-eval
                 (datum->syntax
                  stx
                  `(,#'this-expression-source-file)
                  stx))))
             
             (define (stx-dir dir)
               (path->complete-path (syntax-e dir) stx-pth))]
       #:with [file-spec ...]
       (for*/list ([dir (in-list (syntax->list #'[directory-path ...]))]
                   [dir-file (in-directory (stx-dir dir))]
                   #:when (lang-file? dir-file))
         (datum->syntax
          dir
          `(,#'file
            ,(datum->syntax dir (path->string dir-file) dir))
          dir))
       (syntax/loc stx
         (combine-in file-spec ...))])))

