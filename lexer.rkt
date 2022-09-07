#lang br
(require brag/support)

(define-lex-abbrev reserved-tokens
  (:or "+" "-" "*" "/" "%" "&" "|" "^" "~" "!" "?" ":"
       "==" "<" ">" "<=" ">=" "!="
       "=" "," "." ";"
       ";" "(" ")" "{" "}" "[" "]"
       "true" "false" "null" "return" "if" "else"
       "def" "fn" "switch" "for" "break" "while"
    ))

(define-lex-abbrev digits (:+ (char-set "0123456789")))
(define-lex-abbrev id (:: alphabetic (:* (:or numeric alphabetic))))

(define wobject2-lexer
  (lexer-srcloc
   [whitespace (token lexeme #:skip? #t)]
   [(from/to "#" "\n") (token lexeme #:skip? #t)]
   [reserved-tokens (token lexeme lexeme)]
   [digits (token 'NUMBER (string->number lexeme))]
   [(from/to "\"" "\"") (token 'STRING (trim-ends "\"" lexeme "\""))]
   [id (token 'ID lexeme)]))

(provide wobject2-lexer)