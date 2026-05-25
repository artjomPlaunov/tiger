type lexed_token = {
  token : Parser.token;
  start_pos : int;
}

let is_eof = function Parser.EOF -> true | _ -> false

let token_to_string token start_pos =
  match token with
  | Parser.TYPE -> Printf.sprintf "TYPE   %d" start_pos
  | Parser.VAR -> Printf.sprintf "VAR   %d" start_pos
  | Parser.FUNCTION -> Printf.sprintf "FUNCTION   %d" start_pos
  | Parser.BREAK -> Printf.sprintf "BREAK   %d" start_pos
  | Parser.OF -> Printf.sprintf "OF   %d" start_pos
  | Parser.END -> Printf.sprintf "END   %d" start_pos
  | Parser.IN -> Printf.sprintf "IN   %d" start_pos
  | Parser.NIL -> Printf.sprintf "NIL   %d" start_pos
  | Parser.LET -> Printf.sprintf "LET   %d" start_pos
  | Parser.DO -> Printf.sprintf "DO   %d" start_pos
  | Parser.TO -> Printf.sprintf "TO   %d" start_pos
  | Parser.FOR -> Printf.sprintf "FOR   %d" start_pos
  | Parser.WHILE -> Printf.sprintf "WHILE   %d" start_pos
  | Parser.ELSE -> Printf.sprintf "ELSE   %d" start_pos
  | Parser.THEN -> Printf.sprintf "THEN   %d" start_pos
  | Parser.IF -> Printf.sprintf "IF   %d" start_pos
  | Parser.ARRAY -> Printf.sprintf "ARRAY   %d" start_pos
  | Parser.ASSIGN -> Printf.sprintf "ASSIGN   %d" start_pos
  | Parser.OR -> Printf.sprintf "OR   %d" start_pos
  | Parser.AND -> Printf.sprintf "AND   %d" start_pos
  | Parser.GE -> Printf.sprintf "GE   %d" start_pos
  | Parser.GT -> Printf.sprintf "GT   %d" start_pos
  | Parser.LE -> Printf.sprintf "LE   %d" start_pos
  | Parser.LT -> Printf.sprintf "LT   %d" start_pos
  | Parser.NEQ -> Printf.sprintf "NEQ   %d" start_pos
  | Parser.EQ -> Printf.sprintf "EQ   %d" start_pos
  | Parser.DIVIDE -> Printf.sprintf "DIVIDE   %d" start_pos
  | Parser.TIMES -> Printf.sprintf "TIMES   %d" start_pos
  | Parser.MINUS -> Printf.sprintf "MINUS   %d" start_pos
  | Parser.PLUS -> Printf.sprintf "PLUS   %d" start_pos
  | Parser.DOT -> Printf.sprintf "DOT   %d" start_pos
  | Parser.RBRACE -> Printf.sprintf "RBRACE   %d" start_pos
  | Parser.LBRACE -> Printf.sprintf "LBRACE   %d" start_pos
  | Parser.RBRACK -> Printf.sprintf "RBRACK   %d" start_pos
  | Parser.LBRACK -> Printf.sprintf "LBRACK   %d" start_pos
  | Parser.RPAREN -> Printf.sprintf "RPAREN   %d" start_pos
  | Parser.LPAREN -> Printf.sprintf "LPAREN   %d" start_pos
  | Parser.SEMICOLON -> Printf.sprintf "SEMICOLON   %d" start_pos
  | Parser.COLON -> Printf.sprintf "COLON   %d" start_pos
  | Parser.COMMA -> Printf.sprintf "COMMA   %d" start_pos
  | Parser.STRING value -> Printf.sprintf "STRING(%s)     %d" value start_pos
  | Parser.INT value -> Printf.sprintf "INT(%d)   %d" value start_pos
  | Parser.ID value -> Printf.sprintf "ID(%s)     %d" value start_pos
  | Parser.EOF -> Printf.sprintf "EOF   %d" start_pos

let lex lexbuf =
  let rec loop tokens =
    let token = Lexer.token lexbuf in
    let start_pos = Lexer.token_start () in
    let lexed_token = { token; start_pos } in
    let tokens = lexed_token :: tokens in
    if is_eof token then List.rev tokens else loop tokens
  in
  loop []

let lex_string ?(filename = "<string>") source =
  Error_msg.reset ~filename ();
  let lexbuf = Lexing.from_string source in
  lex lexbuf

let lex_channel ?(filename = "") channel =
  Error_msg.reset ~filename ();
  let lexbuf = Lexing.from_channel channel in
  lex lexbuf

let lex_file filename =
  let channel = open_in filename in
  Fun.protect
    ~finally:(fun () -> close_in_noerr channel)
    (fun () -> lex_channel ~filename channel)

let print_tokens output tokens =
  List.iter
    (fun { token; start_pos } ->
      output_string output (token_to_string token start_pos);
      output_char output '\n')
    tokens

let print_file filename = print_tokens stdout (lex_file filename)
