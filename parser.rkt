#lang brag
wobject-program: (stmt /";")*

stmt: expr | ass | return ; TODO | if | switch | while | for | switch

ass: ID /"=" expr
return: /"return" expr

/expr: sum-expr | not-sum-expr
sum-expr: not-sum-expr (("+" | "-") not-sum-expr)+
@not-sum-expr: prod-expr | not-prod-expr
prod-expr: not-prod-expr (("*"| "/"| "%") not-prod-expr)+
@not-prod-expr: prefix-expr | not-prefix-expr
prefix-expr: ("-" | "+" | "~" | "!")+ not-prefix-expr
@not-prefix-expr: object | array | literal |
  constant | id | def |
  call | /"(" expr /")" ; TODO | fn
id: ID
literal: STRING | NUMBER
constant: "true" | "false" | "null"

object: /"{" [member (/"," member)*] /"}"
member: ID /":" expr
array: /"[" [expr (/"," expr)*] /"]"

def: /"def" ID params block
params: /"(" [ID (/"," ID)*] /")"
block: /"{" wobject-program /"}"
call: expr args
args: /"(" [expr (/"," expr)*] /")"
