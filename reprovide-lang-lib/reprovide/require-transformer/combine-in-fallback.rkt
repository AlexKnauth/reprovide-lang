#lang racket/base

(provide combine-in/fallback allow-in)

(require racket/require-syntax
         racket/require
         (for-syntax racket/base
                     racket/require-transform
                     racket/match
                     (only-in srfi/1 append-reverse)
                     syntax/parse))

(begin-for-syntax
  (define-syntax-class id-maybe-renamed
    #:attributes (orig bind)
    [pattern orig:id #:with bind:id #'orig]
    [pattern [orig:id bind:id]])

  (define ((filter-allow-names alst) str)
    (define sym (string->symbol str))
    (define ent (assq sym alst))
    (and ent (symbol->string (cdr ent))))

  (define (combine-expand-imports/fallback specs local-syms rimps rsrcs)
    (match specs
      ['() (values (reverse rimps) (reverse rsrcs))]
      [(cons s rst)
       (define-values (imps srcs)
         (with-handlers ([exn:fail? (λ (e) (values '() '()))])
           (expand-import s)))
       (define new-imps
         (filter (lambda (i)
                   (not (memq (syntax-e (import-local-id i)) local-syms)))
                 imps))
       (define new-syms
         (map (lambda (i) (syntax-e (import-local-id i))) new-imps))
       (combine-expand-imports/fallback
        rst
        (append-reverse new-syms local-syms)
        (append-reverse new-imps rimps)
        (append-reverse srcs rsrcs))])))

(define-syntax combine-in/fallback
  (make-require-transformer
   (lambda (stx)
     (syntax-parse stx
       [(_ require-spec:expr ...)
        (combine-expand-imports/fallback (attribute require-spec) '() '() '())]))))

;; allow-in is like only-in but more lenient when it doesn't exist
(define-require-syntax allow-in
  (lambda (stx)
    (syntax-parse stx
      [(allow-in require-spec:expr imr:id-maybe-renamed ...)
       (syntax/loc stx
         (filtered-in (filter-allow-names '((imr.orig . imr.bind) ...))
                      require-spec))])))
