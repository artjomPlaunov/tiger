let usage () =
  prerr_endline "usage: tiger-parse FILE";
  exit 64

let () =
  match Array.to_list Sys.argv with
  | [ _; filename ] -> (
      try Tiger.Parse.print_file filename with
      | Tiger.Error_msg.Error -> exit 2)
  | _ -> usage ()
