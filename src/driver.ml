let lex lexbuf =
  let rec loop tokens =
    let token = Lexer.token lexbuf in
    let tokens = token :: tokens in
    if Token.is_eof token then List.rev tokens else loop tokens
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
    (fun token ->
      output_string output (Token.to_string token);
      output_char output '\n')
    tokens

let print_file filename = print_tokens stdout (lex_file filename)
