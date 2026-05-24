type pos = int

type t =
  | TYPE of pos * pos
  | VAR of pos * pos
  | FUNCTION of pos * pos
  | BREAK of pos * pos
  | OF of pos * pos
  | END of pos * pos
  | IN of pos * pos
  | NIL of pos * pos
  | LET of pos * pos
  | DO of pos * pos
  | TO of pos * pos
  | FOR of pos * pos
  | WHILE of pos * pos
  | ELSE of pos * pos
  | THEN of pos * pos
  | IF of pos * pos
  | ARRAY of pos * pos
  | ASSIGN of pos * pos
  | OR of pos * pos
  | AND of pos * pos
  | GE of pos * pos
  | GT of pos * pos
  | LE of pos * pos
  | LT of pos * pos
  | NEQ of pos * pos
  | EQ of pos * pos
  | DIVIDE of pos * pos
  | TIMES of pos * pos
  | MINUS of pos * pos
  | PLUS of pos * pos
  | DOT of pos * pos
  | RBRACE of pos * pos
  | LBRACE of pos * pos
  | RBRACK of pos * pos
  | LBRACK of pos * pos
  | RPAREN of pos * pos
  | LPAREN of pos * pos
  | SEMICOLON of pos * pos
  | COLON of pos * pos
  | COMMA of pos * pos
  | STRING of string * pos * pos
  | INT of int * pos * pos
  | ID of string * pos * pos
  | EOF of pos * pos

val to_string : t -> string
val is_eof : t -> bool
