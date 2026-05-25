let parse lexbuf =
  let current_pos = ref 0 in
  let token lexbuf =
    let token = Lexer.token lexbuf in
    current_pos := Lexer.token_start ();
    token
  in
  try Parser.program token lexbuf with
  | Parsing.Parse_error ->
      Error_msg.error !current_pos "syntax error";
      raise Error_msg.Error

let parse_channel ?(filename = "") channel =
  Error_msg.reset ~filename ();
  let lexbuf = Lexing.from_channel channel in
  parse lexbuf;
  if !(Error_msg.any_errors) then raise Error_msg.Error

let parse_file filename =
  let channel = open_in filename in
  Fun.protect
    ~finally:(fun () -> close_in_noerr channel)
    (fun () -> parse_channel ~filename channel)

let print_file filename =
  parse_file filename;
  print_endline "parse ok"
