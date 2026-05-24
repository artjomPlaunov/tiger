{
let span lexbuf = Lexing.lexeme_start lexbuf, Lexing.lexeme_end lexbuf

let simple lexbuf make =
  let start_pos, end_pos = span lexbuf in
  make start_pos end_pos

let keyword_or_id lexbuf =
  simple lexbuf (fun start_pos end_pos ->
    match Lexing.lexeme lexbuf with
    | "type" -> Token.TYPE (start_pos, end_pos)
    | "var" -> Token.VAR (start_pos, end_pos)
    | "function" -> Token.FUNCTION (start_pos, end_pos)
    | "break" -> Token.BREAK (start_pos, end_pos)
    | "of" -> Token.OF (start_pos, end_pos)
    | "end" -> Token.END (start_pos, end_pos)
    | "in" -> Token.IN (start_pos, end_pos)
    | "nil" -> Token.NIL (start_pos, end_pos)
    | "let" -> Token.LET (start_pos, end_pos)
    | "do" -> Token.DO (start_pos, end_pos)
    | "to" -> Token.TO (start_pos, end_pos)
    | "for" -> Token.FOR (start_pos, end_pos)
    | "while" -> Token.WHILE (start_pos, end_pos)
    | "else" -> Token.ELSE (start_pos, end_pos)
    | "then" -> Token.THEN (start_pos, end_pos)
    | "if" -> Token.IF (start_pos, end_pos)
    | "array" -> Token.ARRAY (start_pos, end_pos)
    | name -> Token.ID (name, start_pos, end_pos))

let int_token lexbuf =
  let start_pos, end_pos = span lexbuf in
  let value =
    match int_of_string_opt (Lexing.lexeme lexbuf) with
    | Some value -> value
    | None ->
        Error_msg.error start_pos "integer too large";
        1
  in
  Token.INT (value, start_pos, end_pos)

let string_buffer = Buffer.create 128

let string_token start_pos lexbuf =
  Token.STRING (Buffer.contents string_buffer, start_pos, Lexing.lexeme_end lexbuf)

let unterminated_string_token start_pos lexbuf =
  Error_msg.error start_pos "unclosed string";
  Token.STRING (Buffer.contents string_buffer, start_pos, Lexing.lexeme_start lexbuf)

let newline lexbuf =
  incr Error_msg.line_num;
  Error_msg.line_pos := Lexing.lexeme_end lexbuf :: !(Error_msg.line_pos)

let eof_token lexbuf =
  let pos = Lexing.lexeme_start lexbuf in
  Token.EOF (pos, pos)

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
  | ":=" { simple lexbuf (fun start_pos end_pos -> Token.ASSIGN (start_pos, end_pos)) }
  | "|" { simple lexbuf (fun start_pos end_pos -> Token.OR (start_pos, end_pos)) }
  | "&" { simple lexbuf (fun start_pos end_pos -> Token.AND (start_pos, end_pos)) }
  | ">=" { simple lexbuf (fun start_pos end_pos -> Token.GE (start_pos, end_pos)) }
  | ">" { simple lexbuf (fun start_pos end_pos -> Token.GT (start_pos, end_pos)) }
  | "<=" { simple lexbuf (fun start_pos end_pos -> Token.LE (start_pos, end_pos)) }
  | "<" { simple lexbuf (fun start_pos end_pos -> Token.LT (start_pos, end_pos)) }
  | "<>" { simple lexbuf (fun start_pos end_pos -> Token.NEQ (start_pos, end_pos)) }
  | "=" { simple lexbuf (fun start_pos end_pos -> Token.EQ (start_pos, end_pos)) }
  | "/" { simple lexbuf (fun start_pos end_pos -> Token.DIVIDE (start_pos, end_pos)) }
  | "*" { simple lexbuf (fun start_pos end_pos -> Token.TIMES (start_pos, end_pos)) }
  | "-" { simple lexbuf (fun start_pos end_pos -> Token.MINUS (start_pos, end_pos)) }
  | "+" { simple lexbuf (fun start_pos end_pos -> Token.PLUS (start_pos, end_pos)) }
  | "." { simple lexbuf (fun start_pos end_pos -> Token.DOT (start_pos, end_pos)) }
  | "}" { simple lexbuf (fun start_pos end_pos -> Token.RBRACE (start_pos, end_pos)) }
  | "{" { simple lexbuf (fun start_pos end_pos -> Token.LBRACE (start_pos, end_pos)) }
  | "]" { simple lexbuf (fun start_pos end_pos -> Token.RBRACK (start_pos, end_pos)) }
  | "[" { simple lexbuf (fun start_pos end_pos -> Token.LBRACK (start_pos, end_pos)) }
  | ")" { simple lexbuf (fun start_pos end_pos -> Token.RPAREN (start_pos, end_pos)) }
  | "(" { simple lexbuf (fun start_pos end_pos -> Token.LPAREN (start_pos, end_pos)) }
  | ";" { simple lexbuf (fun start_pos end_pos -> Token.SEMICOLON (start_pos, end_pos)) }
  | ":" { simple lexbuf (fun start_pos end_pos -> Token.COLON (start_pos, end_pos)) }
  | "," { simple lexbuf (fun start_pos end_pos -> Token.COMMA (start_pos, end_pos)) }
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
