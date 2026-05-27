val parse : Lexing.lexbuf -> Absyn.exp
val parse_channel : ?filename:string -> in_channel -> Absyn.exp
val parse_file : string -> Absyn.exp
val print_file : string -> unit
