let usage () =
  prerr_endline "usage: tiger-lex FILE";
  exit 64

let () =
  match Array.to_list Sys.argv with
  | [ _; filename ] -> Tiger.Driver.print_file filename
  | _ -> usage ()
