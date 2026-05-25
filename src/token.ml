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

let fixed name span = Printf.sprintf "%s   %d" name span.start_pos
let string_payload name value span =
  Printf.sprintf "%s(%s)     %d" name value span.start_pos

let int_payload value span = Printf.sprintf "INT(%d)   %d" value span.start_pos

let to_string { kind; span } =
  match kind with
  | TYPE -> fixed "TYPE" span
  | VAR -> fixed "VAR" span
  | FUNCTION -> fixed "FUNCTION" span
  | BREAK -> fixed "BREAK" span
  | OF -> fixed "OF" span
  | END -> fixed "END" span
  | IN -> fixed "IN" span
  | NIL -> fixed "NIL" span
  | LET -> fixed "LET" span
  | DO -> fixed "DO" span
  | TO -> fixed "TO" span
  | FOR -> fixed "FOR" span
  | WHILE -> fixed "WHILE" span
  | ELSE -> fixed "ELSE" span
  | THEN -> fixed "THEN" span
  | IF -> fixed "IF" span
  | ARRAY -> fixed "ARRAY" span
  | ASSIGN -> fixed "ASSIGN" span
  | OR -> fixed "OR" span
  | AND -> fixed "AND" span
  | GE -> fixed "GE" span
  | GT -> fixed "GT" span
  | LE -> fixed "LE" span
  | LT -> fixed "LT" span
  | NEQ -> fixed "NEQ" span
  | EQ -> fixed "EQ" span
  | DIVIDE -> fixed "DIVIDE" span
  | TIMES -> fixed "TIMES" span
  | MINUS -> fixed "MINUS" span
  | PLUS -> fixed "PLUS" span
  | DOT -> fixed "DOT" span
  | RBRACE -> fixed "RBRACE" span
  | LBRACE -> fixed "LBRACE" span
  | RBRACK -> fixed "RBRACK" span
  | LBRACK -> fixed "LBRACK" span
  | RPAREN -> fixed "RPAREN" span
  | LPAREN -> fixed "LPAREN" span
  | SEMICOLON -> fixed "SEMICOLON" span
  | COLON -> fixed "COLON" span
  | COMMA -> fixed "COMMA" span
  | STRING value -> string_payload "STRING" value span
  | INT value -> int_payload value span
  | ID value -> string_payload "ID" value span
  | EOF -> fixed "EOF" span

let is_eof = function { kind = EOF; _ } -> true | _ -> false
