#lang br/quicklang
(require "parser.rkt" "tokenizer.rkt")

(define (desugar-stmt parse-tree)
  #f)

(define (desugar-expr parse-tree)
  #f)

(define (desugar parse-tree)
  (map desugar-stmt parse-tree))
(provide desugar)

(define (do-parse port [path #f])
  (parse path (make-tokenizer port path)))

(define (read-syntax path port)
  #`(module desugar-mod wobject2/desugar
      #,(do-parse port path)))
(module+ reader (provide read-syntax))

(define-macro (desugar-mb PARSE-TREE)
  (let ((abstract-tree 'PARSE-TREE))
    #`(#%module-begin
       #,abstract-tree)))
(provide (rename-out [desugar-mb #%module-begin]))
