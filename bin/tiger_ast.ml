let usage () =
  prerr_endline "usage: tiger-ast FILE";
  exit 64

let () =
  match Array.to_list Sys.argv with
  | [ _; filename ] -> (
      try
        let ast = Tiger.Parse.parse_file filename in
        Tiger.Print_absyn.print stdout ast
      with Tiger.Error_msg.Error -> exit 2)
  | _ -> usage ()
