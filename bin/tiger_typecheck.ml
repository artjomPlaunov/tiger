let usage () =
  prerr_endline "usage: tiger-typecheck FILE";
  exit 64

let typecheck_file filename =
  let ast = Tiger.Parse.parse_file filename in
  Tiger.Semant.trans_prog ast;
  if !(Tiger.Error_msg.any_errors) then raise Tiger.Error_msg.Error;
  print_endline "typecheck ok"

let () =
  match Array.to_list Sys.argv with
  | [ _; filename ] -> (
      try typecheck_file filename with
      | Tiger.Error_msg.Error -> exit 2)
  | _ -> usage ()
