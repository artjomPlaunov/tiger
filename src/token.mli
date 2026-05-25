type pos = int

type span = {
  start_pos : pos;
  end_pos : pos;
}

type kind =
  | TYPE
  | VAR
  | FUNCTION
  | BREAK
  | OF
  | END
  | IN
  | NIL
  | LET
  | DO
  | TO
  | FOR
  | WHILE
  | ELSE
  | THEN
  | IF
  | ARRAY
  | ASSIGN
  | OR
  | AND
  | GE
  | GT
  | LE
  | LT
  | NEQ
  | EQ
  | DIVIDE
  | TIMES
  | MINUS
  | PLUS
  | DOT
  | RBRACE
  | LBRACE
  | RBRACK
  | LBRACK
  | RPAREN
  | LPAREN
  | SEMICOLON
  | COLON
  | COMMA
  | STRING of string
  | INT of int
  | ID of string
  | EOF

type t = {
  kind : kind;
  span : span;
}

val to_string : t -> string
val is_eof : t -> bool
