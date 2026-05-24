let any_errors = ref false
let file_name = ref ""
let line_num = ref 1
let line_pos = ref [ 0 ]

exception Error

let reset ?(filename = "") () =
  any_errors := false;
  file_name := filename;
  line_num := 1;
  line_pos := [ 0 ]

let location pos =
  let rec look starts line =
    match starts with
    | start :: _ when start <= pos -> Printf.sprintf "%d.%d" line (pos - start)
    | _ :: rest -> look rest (line - 1)
    | [] -> "0.0"
  in
  look !line_pos !line_num

let error pos msg =
  any_errors := true;
  Printf.eprintf "%s:%s:%s\n" !file_name (location pos) msg

let impossible msg =
  Printf.eprintf "Error: Compiler bug: %s\n" msg;
  raise Error
