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

let to_string = function
  | TYPE (i, _) -> Printf.sprintf "TYPE   %d" i
  | VAR (i, _) -> Printf.sprintf "VAR   %d" i
  | FUNCTION (i, _) -> Printf.sprintf "FUNCTION   %d" i
  | BREAK (i, _) -> Printf.sprintf "BREAK   %d" i
  | OF (i, _) -> Printf.sprintf "OF   %d" i
  | END (i, _) -> Printf.sprintf "END   %d" i
  | IN (i, _) -> Printf.sprintf "IN   %d" i
  | NIL (i, _) -> Printf.sprintf "NIL   %d" i
  | LET (i, _) -> Printf.sprintf "LET   %d" i
  | DO (i, _) -> Printf.sprintf "DO   %d" i
  | TO (i, _) -> Printf.sprintf "TO   %d" i
  | FOR (i, _) -> Printf.sprintf "FOR   %d" i
  | WHILE (i, _) -> Printf.sprintf "WHILE   %d" i
  | ELSE (i, _) -> Printf.sprintf "ELSE   %d" i
  | THEN (i, _) -> Printf.sprintf "THEN   %d" i
  | IF (i, _) -> Printf.sprintf "IF   %d" i
  | ARRAY (i, _) -> Printf.sprintf "ARRAY   %d" i
  | ASSIGN (i, _) -> Printf.sprintf "ASSIGN   %d" i
  | OR (i, _) -> Printf.sprintf "OR   %d" i
  | AND (i, _) -> Printf.sprintf "AND   %d" i
  | GE (i, _) -> Printf.sprintf "GE   %d" i
  | GT (i, _) -> Printf.sprintf "GT   %d" i
  | LE (i, _) -> Printf.sprintf "LE   %d" i
  | LT (i, _) -> Printf.sprintf "LT   %d" i
  | NEQ (i, _) -> Printf.sprintf "NEQ   %d" i
  | EQ (i, _) -> Printf.sprintf "EQ   %d" i
  | DIVIDE (i, _) -> Printf.sprintf "DIVIDE   %d" i
  | TIMES (i, _) -> Printf.sprintf "TIMES   %d" i
  | MINUS (i, _) -> Printf.sprintf "MINUS   %d" i
  | PLUS (i, _) -> Printf.sprintf "PLUS   %d" i
  | DOT (i, _) -> Printf.sprintf "DOT   %d" i
  | RBRACE (i, _) -> Printf.sprintf "RBRACE   %d" i
  | LBRACE (i, _) -> Printf.sprintf "LBRACE   %d" i
  | RBRACK (i, _) -> Printf.sprintf "RBRACK   %d" i
  | LBRACK (i, _) -> Printf.sprintf "LBRACK   %d" i
  | RPAREN (i, _) -> Printf.sprintf "RPAREN   %d" i
  | LPAREN (i, _) -> Printf.sprintf "LPAREN   %d" i
  | SEMICOLON (i, _) -> Printf.sprintf "SEMICOLON   %d" i
  | COLON (i, _) -> Printf.sprintf "COLON   %d" i
  | COMMA (i, _) -> Printf.sprintf "COMMA   %d" i
  | STRING (s, i, _) -> Printf.sprintf "STRING(%s)     %d" s i
  | INT (c, i, _) -> Printf.sprintf "INT(%d)   %d" c i
  | ID (s, i, _) -> Printf.sprintf "ID(%s)     %d" s i
  | EOF (i, _) -> Printf.sprintf "EOF   %d" i

let is_eof = function EOF _ -> true | _ -> false
