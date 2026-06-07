open Absyn

type tree = Node of string * tree list

let node label children = Node (label, children)
let leaf label = Node (label, [])

let oper_name = function
  | PlusOp -> "PlusOp"
  | MinusOp -> "MinusOp"
  | TimesOp -> "TimesOp"
  | DivideOp -> "DivideOp"
  | EqOp -> "EqOp"
  | NeqOp -> "NeqOp"
  | LtOp -> "LtOp"
  | LeOp -> "LeOp"
  | GtOp -> "GtOp"
  | GeOp -> "GeOp"

let named label child = node label [ child ]

let option_tree label value to_tree =
  match value with
  | None -> leaf (label ^ ": none")
  | Some value -> named label (to_tree value)

let symbol_pos_tree label value =
	match value with
	| None -> leaf (label ^ ": none")
	| Some (symbol_value, _) -> leaf (label ^ ": " ^ Symbol.to_string symbol_value)

let field_tree { name; escape; typ; _ } =
	leaf
	  (Printf.sprintf "Field %s : %s escape=%b" (Symbol.to_string name) (Symbol.to_string typ)
	     !escape)

let rec var_tree = function
	| SimpleVar (name, _) -> leaf ("SimpleVar " ^ Symbol.to_string name)
	| FieldVar (var, field, _) -> node ("FieldVar " ^ Symbol.to_string field) [ var_tree var ]
  | SubscriptVar (var, index, _) ->
      node "SubscriptVar" [ named "var" (var_tree var); named "index" (exp_tree index) ]

and exp_tree = function
  | VarExp var -> named "VarExp" (var_tree var)
  | NilExp -> leaf "NilExp"
  | IntExp value -> leaf ("IntExp " ^ string_of_int value)
  | StringExp (value, _) -> leaf ("StringExp " ^ Printf.sprintf "%S" value)
	| CallExp { func; args; _ } -> node ("CallExp " ^ Symbol.to_string func) (List.map exp_tree args)
  | OpExp { left; oper; right; _ } ->
      node ("OpExp " ^ oper_name oper) [ exp_tree left; exp_tree right ]
	| RecordExp { fields; typ; _ } ->
	    let field_tree (name, exp, _) = node ("Field " ^ Symbol.to_string name) [ exp_tree exp ] in
	    node ("RecordExp " ^ Symbol.to_string typ) (List.map field_tree fields)
  | SeqExp expressions ->
      node "SeqExp" (List.map (fun (exp, _) -> exp_tree exp) expressions)
  | AssignExp { var; exp; _ } ->
      node "AssignExp" [ named "var" (var_tree var); named "exp" (exp_tree exp) ]
  | IfExp { test; then_; else_; _ } ->
      let children =
        [
          named "test" (exp_tree test);
          named "then" (exp_tree then_);
          option_tree "else" else_ exp_tree;
        ]
      in
      node "IfExp" children
  | WhileExp { test; body; _ } ->
      node "WhileExp" [ named "test" (exp_tree test); named "body" (exp_tree body) ]
	| ForExp { var; escape; lo; hi; body; _ } ->
	    node
	      (Printf.sprintf "ForExp %s escape=%b" (Symbol.to_string var) !escape)
        [ named "lo" (exp_tree lo); named "hi" (exp_tree hi); named "body" (exp_tree body) ]
  | BreakExp _ -> leaf "BreakExp"
  | LetExpr { decs; body; _ } ->
      node "LetExp" [ node "decs" (List.map dec_tree decs); named "body" (exp_tree body) ]
	| ArrayExp { typ; size; init; _ } ->
	    node
	      ("ArrayExp " ^ Symbol.to_string typ)
        [ named "size" (exp_tree size); named "init" (exp_tree init) ]

and dec_tree = function
  | FunctionDec functions -> node "FunctionDec" (List.map fundec_tree functions)
	| VarDec { name; escape; typ; init; _ } ->
	    node
	      (Printf.sprintf "VarDec %s escape=%b" (Symbol.to_string name) !escape)
	      [ symbol_pos_tree "type" typ; named "init" (exp_tree init) ]
  | TypeDec types -> node "TypeDec" (List.map typedec_tree types)

and typedec_tree { name; ty; _ } = node ("Type " ^ Symbol.to_string name) [ ty_tree ty ]

and fundec_tree { name; params; result; body; _ } =
	node
	  ("Function " ^ Symbol.to_string name)
    [
      node "params" (List.map field_tree params);
      symbol_pos_tree "result" result;
      named "body" (exp_tree body);
    ]

and ty_tree = function
	| NameTy (name, _) -> leaf ("NameTy " ^ Symbol.to_string name)
	| RecordTy fields -> node "RecordTy" (List.map field_tree fields)
	| ArrayTy (name, _) -> leaf ("ArrayTy " ^ Symbol.to_string name)

let render_tree tree =
  let buffer = Buffer.create 512 in
  Buffer.add_string buffer "╭─ Tiger AST\n";
  let rec print_node prefix is_last is_root (Node (label, children)) =
    if is_root then Buffer.add_string buffer "╰─ "
    else (
      Buffer.add_string buffer prefix;
      Buffer.add_string buffer (if is_last then "╰─ " else "├─ "));
    Buffer.add_string buffer label;
    Buffer.add_char buffer '\n';
    let child_prefix =
      if is_root then "   " else prefix ^ (if is_last then "   " else "│  ")
    in
    let rec print_children = function
      | [] -> ()
      | [ child ] -> print_node child_prefix true false child
      | child :: rest ->
          print_node child_prefix false false child;
          print_children rest
    in
    print_children children
  in
  print_node "" true true tree;
  Buffer.contents buffer

let print_tree output tree = output_string output (render_tree tree)

let print output exp = print_tree output (exp_tree exp)

let to_string exp = render_tree (exp_tree exp)
