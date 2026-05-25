{
let last_token_start = ref 0

let token_start () = !last_token_start

let make_token lexbuf token =
  last_token_start := Lexing.lexeme_start lexbuf;
  token

let keyword_or_id lexbuf =
  let token =
    match Lexing.lexeme lexbuf with
    | "type" -> Parser.TYPE
    | "var" -> Parser.VAR
    | "function" -> Parser.FUNCTION
    | "break" -> Parser.BREAK
    | "of" -> Parser.OF
    | "end" -> Parser.END
    | "in" -> Parser.IN
    | "nil" -> Parser.NIL
    | "let" -> Parser.LET
    | "do" -> Parser.DO
    | "to" -> Parser.TO
    | "for" -> Parser.FOR
    | "while" -> Parser.WHILE
    | "else" -> Parser.ELSE
    | "then" -> Parser.THEN
    | "if" -> Parser.IF
    | "array" -> Parser.ARRAY
    | name -> Parser.ID name
  in
  make_token lexbuf token

let int_token lexbuf =
  let start_pos = Lexing.lexeme_start lexbuf in
  last_token_start := start_pos;
  let value =
    match int_of_string_opt (Lexing.lexeme lexbuf) with
    | Some value -> value
    | None ->
        Error_msg.error start_pos "integer too large";
        1
  in
  Parser.INT value

let string_buffer = Buffer.create 128

let string_token start_pos =
  last_token_start := start_pos;
  Parser.STRING (Buffer.contents string_buffer)

let unterminated_string_token start_pos =
  last_token_start := start_pos;
  Error_msg.error start_pos "unclosed string";
  Parser.STRING (Buffer.contents string_buffer)

let newline lexbuf =
  incr Error_msg.line_num;
  Error_msg.line_pos := Lexing.lexeme_end lexbuf :: !(Error_msg.line_pos)

let eof_token lexbuf =
  last_token_start := Lexing.lexeme_start lexbuf;
  Parser.EOF

let add_decimal_escape lexbuf =
  let start_pos = Lexing.lexeme_start lexbuf in
  let code = int_of_string (Lexing.lexeme lexbuf) in
  if code > 255
  then Error_msg.error start_pos "illegal ascii escape"
  else Buffer.add_char string_buffer (Char.chr code)

let add_control_escape lexbuf =
  let text = Lexing.lexeme lexbuf in
  let code = Char.code text.[1] - Char.code '@' in
  Buffer.add_char string_buffer (Char.chr code)
}

let digit = ['0'-'9']
let letter = ['A'-'Z'] | ['a'-'z']
let id = letter (letter | digit | '_')*
let whitespace = [' ' '\t' '\012']
let newline = "\r\n" | '\n' | '\r'

rule token = parse
  | "/*" { comment 1 lexbuf; token lexbuf }
  | "*/" {
      Error_msg.error (Lexing.lexeme_start lexbuf) "unmatched close comment";
      token lexbuf
    }
  | newline { newline lexbuf; token lexbuf }
  | whitespace+ { token lexbuf }
  | ":=" { make_token lexbuf Parser.ASSIGN }
  | "|" { make_token lexbuf Parser.OR }
  | "&" { make_token lexbuf Parser.AND }
  | ">=" { make_token lexbuf Parser.GE }
  | ">" { make_token lexbuf Parser.GT }
  | "<=" { make_token lexbuf Parser.LE }
  | "<" { make_token lexbuf Parser.LT }
  | "<>" { make_token lexbuf Parser.NEQ }
  | "=" { make_token lexbuf Parser.EQ }
  | "/" { make_token lexbuf Parser.DIVIDE }
  | "*" { make_token lexbuf Parser.TIMES }
  | "-" { make_token lexbuf Parser.MINUS }
  | "+" { make_token lexbuf Parser.PLUS }
  | "." { make_token lexbuf Parser.DOT }
  | "}" { make_token lexbuf Parser.RBRACE }
  | "{" { make_token lexbuf Parser.LBRACE }
  | "]" { make_token lexbuf Parser.RBRACK }
  | "[" { make_token lexbuf Parser.LBRACK }
  | ")" { make_token lexbuf Parser.RPAREN }
  | "(" { make_token lexbuf Parser.LPAREN }
  | ";" { make_token lexbuf Parser.SEMICOLON }
  | ":" { make_token lexbuf Parser.COLON }
  | "," { make_token lexbuf Parser.COMMA }
  | digit+ { int_token lexbuf }
  | id { keyword_or_id lexbuf }
  | '"' {
      Buffer.clear string_buffer;
      string (Lexing.lexeme_start lexbuf) lexbuf
    }
  | _ {
      Error_msg.error
        (Lexing.lexeme_start lexbuf)
        ("illegal character " ^ Lexing.lexeme lexbuf);
      token lexbuf
    }
  | eof { eof_token lexbuf }

and comment depth = parse
  | "/*" { comment (depth + 1) lexbuf }
  | "*/" {
      if depth = 1 then ()
      else comment (depth - 1) lexbuf
    }
  | newline { newline lexbuf; comment depth lexbuf }
  | _ { comment depth lexbuf }
  | eof {
      Error_msg.error
        (Lexing.lexeme_start lexbuf)
        "unclosed comment"
    }

and string start_pos = parse
  | '"' { string_token start_pos }
  | '\\' { string_escape start_pos lexbuf }
  | newline {
      let token = unterminated_string_token start_pos in
      newline lexbuf;
      token
    }
  | [^ '"' '\\' '\n' '\r']+ {
      Buffer.add_string string_buffer (Lexing.lexeme lexbuf);
      string start_pos lexbuf
    }
  | eof { unterminated_string_token start_pos }

and string_escape start_pos = parse
  | 'n' { Buffer.add_char string_buffer '\n'; string start_pos lexbuf }
  | 't' { Buffer.add_char string_buffer '\t'; string start_pos lexbuf }
  | '"' { Buffer.add_char string_buffer '"'; string start_pos lexbuf }
  | '\\' { Buffer.add_char string_buffer '\\'; string start_pos lexbuf }
  | '^' ['@'-'_'] { add_control_escape lexbuf; string start_pos lexbuf }
  | digit digit digit { add_decimal_escape lexbuf; string start_pos lexbuf }
  | whitespace+ { string_gap start_pos lexbuf }
  | newline { newline lexbuf; string_gap start_pos lexbuf }
  | eof { unterminated_string_token start_pos }
  | _ {
      Error_msg.error (Lexing.lexeme_start lexbuf) "illegal string escape";
      string start_pos lexbuf
    }

and string_gap start_pos = parse
  | whitespace+ { string_gap start_pos lexbuf }
  | newline { newline lexbuf; string_gap start_pos lexbuf }
  | '\\' { string start_pos lexbuf }
  | eof { unterminated_string_token start_pos }
  | _ {
      Error_msg.error (Lexing.lexeme_start lexbuf) "illegal string escape";
      string start_pos lexbuf
    }
