{
let span lexbuf =
  Token.
    {
      start_pos = Lexing.lexeme_start lexbuf;
      end_pos = Lexing.lexeme_end lexbuf;
    }

let make_token lexbuf kind = Token.{ kind; span = span lexbuf }

let keyword_or_id lexbuf =
  let kind =
    match Lexing.lexeme lexbuf with
    | "type" -> Token.TYPE
    | "var" -> Token.VAR
    | "function" -> Token.FUNCTION
    | "break" -> Token.BREAK
    | "of" -> Token.OF
    | "end" -> Token.END
    | "in" -> Token.IN
    | "nil" -> Token.NIL
    | "let" -> Token.LET
    | "do" -> Token.DO
    | "to" -> Token.TO
    | "for" -> Token.FOR
    | "while" -> Token.WHILE
    | "else" -> Token.ELSE
    | "then" -> Token.THEN
    | "if" -> Token.IF
    | "array" -> Token.ARRAY
    | name -> Token.ID name
  in
  make_token lexbuf kind

let int_token lexbuf =
  let span = span lexbuf in
  let value =
    match int_of_string_opt (Lexing.lexeme lexbuf) with
    | Some value -> value
    | None ->
        Error_msg.error span.start_pos "integer too large";
        1
  in
  Token.{ kind = INT value; span }

let string_buffer = Buffer.create 128

let string_token start_pos lexbuf =
  Token.
    {
      kind = STRING (Buffer.contents string_buffer);
      span = { start_pos; end_pos = Lexing.lexeme_end lexbuf };
    }

let unterminated_string_token start_pos lexbuf =
  Error_msg.error start_pos "unclosed string";
  Token.
    {
      kind = STRING (Buffer.contents string_buffer);
      span = { start_pos; end_pos = Lexing.lexeme_start lexbuf };
    }

let newline lexbuf =
  incr Error_msg.line_num;
  Error_msg.line_pos := Lexing.lexeme_end lexbuf :: !(Error_msg.line_pos)

let eof_token lexbuf =
  let pos = Lexing.lexeme_start lexbuf in
  Token.{ kind = EOF; span = { start_pos = pos; end_pos = pos } }

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
  | ":=" { make_token lexbuf Token.ASSIGN }
  | "|" { make_token lexbuf Token.OR }
  | "&" { make_token lexbuf Token.AND }
  | ">=" { make_token lexbuf Token.GE }
  | ">" { make_token lexbuf Token.GT }
  | "<=" { make_token lexbuf Token.LE }
  | "<" { make_token lexbuf Token.LT }
  | "<>" { make_token lexbuf Token.NEQ }
  | "=" { make_token lexbuf Token.EQ }
  | "/" { make_token lexbuf Token.DIVIDE }
  | "*" { make_token lexbuf Token.TIMES }
  | "-" { make_token lexbuf Token.MINUS }
  | "+" { make_token lexbuf Token.PLUS }
  | "." { make_token lexbuf Token.DOT }
  | "}" { make_token lexbuf Token.RBRACE }
  | "{" { make_token lexbuf Token.LBRACE }
  | "]" { make_token lexbuf Token.RBRACK }
  | "[" { make_token lexbuf Token.LBRACK }
  | ")" { make_token lexbuf Token.RPAREN }
  | "(" { make_token lexbuf Token.LPAREN }
  | ";" { make_token lexbuf Token.SEMICOLON }
  | ":" { make_token lexbuf Token.COLON }
  | "," { make_token lexbuf Token.COMMA }
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
  | '"' { string_token start_pos lexbuf }
  | '\\' { string_escape start_pos lexbuf }
  | newline {
      let token = unterminated_string_token start_pos lexbuf in
      newline lexbuf;
      token
    }
  | [^ '"' '\\' '\n' '\r']+ {
      Buffer.add_string string_buffer (Lexing.lexeme lexbuf);
      string start_pos lexbuf
    }
  | eof { unterminated_string_token start_pos lexbuf }

and string_escape start_pos = parse
  | 'n' { Buffer.add_char string_buffer '\n'; string start_pos lexbuf }
  | 't' { Buffer.add_char string_buffer '\t'; string start_pos lexbuf }
  | '"' { Buffer.add_char string_buffer '"'; string start_pos lexbuf }
  | '\\' { Buffer.add_char string_buffer '\\'; string start_pos lexbuf }
  | '^' ['@'-'_'] { add_control_escape lexbuf; string start_pos lexbuf }
  | digit digit digit { add_decimal_escape lexbuf; string start_pos lexbuf }
  | whitespace+ { string_gap start_pos lexbuf }
  | newline { newline lexbuf; string_gap start_pos lexbuf }
  | eof { unterminated_string_token start_pos lexbuf }
  | _ {
      Error_msg.error (Lexing.lexeme_start lexbuf) "illegal string escape";
      string start_pos lexbuf
    }

and string_gap start_pos = parse
  | whitespace+ { string_gap start_pos lexbuf }
  | newline { newline lexbuf; string_gap start_pos lexbuf }
  | '\\' { string start_pos lexbuf }
  | eof { unterminated_string_token start_pos lexbuf }
  | _ {
      Error_msg.error (Lexing.lexeme_start lexbuf) "illegal string escape";
      string start_pos lexbuf
    }
