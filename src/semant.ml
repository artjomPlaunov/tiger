open Absyn

type venv = Env.enventry Symbol.table
type tenv = Types.ty Symbol.table
type expr_ty = { expr : Translate.expr; ty : Types.ty }

let check_int ({ ty; _ } : expr_ty) pos =
  match Types.actual ty with
  | Types.Int | Types.Error -> ()
  | _ -> Error_msg.error pos "integer required"

let check_unit ({ ty; _ } : expr_ty) pos = 
  match Types.actual ty with 
  | Types.Unit | Types.Error -> ()
  | _ -> Error_msg.error pos "unit required"

let rec trans_expr venv tenv expr =
  let rec tr_expr expr =
    match expr with
    | VarExpr var -> tr_var var
    | NilExpr -> {expr=(); ty=Types.Nil}
    | IntExpr _ -> { expr = (); ty = Types.Int }
    | StringExpr (_, _) -> { expr = (); ty = Types.String }
    | CallExpr { func; args; pos } -> tr_call func args pos
    | SeqExpr exprs -> tr_seq_expr exprs
    | AssignExpr { var; expr; pos } -> tr_assign var expr pos
    | OpExpr { left; oper; right; pos } -> tr_op left oper right pos
    | IfExpr { test; then_; else_; pos } -> tr_if_expr test then_ else_ pos
    | LetExpr { decs; body; pos } -> tr_let decs body pos
    | _ -> failwith "todo"

  (* Variables. *)
  and tr_var var =
    match var with
    | SimpleVar (name, pos) -> (
        match Symbol.look name venv with
        | Some (Env.VarEntry { ty }) -> { expr = (); ty = Types.actual ty }
        | Some (Env.FunEntry _) ->
            Error_msg.error pos "function used as variable";
            { expr = (); ty = Types.Error }
        | None ->
            Error_msg.error pos "undefined variable";
            { expr = (); ty = Types.Error })
    | _ -> failwith "todo"

  (* Function calls. *)
  and tr_call func args pos =
    match Symbol.look func venv with
    | Some (Env.FunEntry { formals; result }) ->
        check_args pos formals args;
        { expr = (); ty = Types.actual result }
    | Some (Env.VarEntry _) ->
        Error_msg.error pos "variable used as function";
        { expr = (); ty = Types.Error }
    | None ->
        Error_msg.error pos "undefined function";
        { expr = (); ty = Types.Error }

  (* Call arguments. *)
  and check_args pos formals args =
    match (formals, args) with
    | [], [] -> ()
    | [], extra_args ->
        List.iter (fun arg -> ignore (tr_expr arg)) extra_args;
        Error_msg.error pos "too many arguments"
    | _ :: _, [] -> Error_msg.error pos "too few arguments"
    | formal :: formals, arg :: args ->
        let trans_arg_expr = tr_expr arg in
        if not (Types.compatible formal trans_arg_expr.ty) then
          Error_msg.error pos "argument type mismatch";
        check_args pos formals args

  and tr_seq_expr exprs = 
    match exprs with 
    | [] -> { expr = (); ty = Types.Unit }
    | [(expr, _)] -> 
        let trans_expr = tr_expr expr in 
        { expr = (); ty = trans_expr.ty }
    | (expr, _)::exprs -> 
        ignore (tr_expr expr);
        tr_seq_expr exprs

  and tr_assign var expr pos = 
    let var_ty = tr_var var in 
    let expr_ty = tr_expr expr in 
    if not (Types.compatible var_ty.ty expr_ty.ty) 
    then Error_msg.error pos "assignment expression types not compatible";
    { expr = (); ty = Types.Unit }

  (* Operators. *)
  and tr_op left oper right pos =
    let left_expr_ty = tr_expr left in
    let right_expr_ty = tr_expr right in
    match oper with
    | PlusOp | MinusOp | TimesOp | DivideOp ->
        check_int left_expr_ty pos;
        check_int right_expr_ty pos;
        { expr = (); ty = Types.Int }
    | EqOp | NeqOp ->
        if Types.compatible left_expr_ty.ty right_expr_ty.ty then
          { expr = (); ty = Types.Int }
        else (
          Error_msg.error pos "same type required";
          { expr = (); ty = Types.Error })
    | LtOp | LeOp | GtOp | GeOp -> (
        match (Types.actual left_expr_ty.ty, Types.actual right_expr_ty.ty) with
        | Types.Int, Types.Int
        | Types.String, Types.String ->
            { expr = (); ty = Types.Int }
        | _ ->
            Error_msg.error pos "integer or string required";
            { expr = (); ty = Types.Error })

  (* If Expr *)
  and tr_if_expr test then_ else_ pos = 
    let test_expr = tr_expr test in 
    check_int test_expr pos;
    match else_ with 
    | Some e -> tr_if_else then_ e pos 
    | None -> tr_if then_ pos

  (* If then *)
  and tr_if then_ pos = 
    let then_expr = tr_expr then_ in 
    check_unit then_expr pos;
    { expr = (); ty = Types.Unit }

  (* If then else *)
  and tr_if_else then_ else_ pos = 
    let then_expr = tr_expr then_ in 
    let else_expr = tr_expr else_ in 
    if Types.compatible then_expr.ty else_expr.ty 
    then 
      { expr = (); ty = then_expr.ty }
    else (
      Error_msg.error pos "then and else branches must have the same type";
      { expr = (); ty = Types.Error }
    )

  (* Let Expr *)
  and tr_let decs body _pos = 
    let venv', tenv' = trans_decs venv tenv decs
    in
    trans_expr venv' tenv' body
  in
  tr_expr expr

and trans_dec venv tenv dec = 
  match dec with 
  | VarDec {name; typ; init; escape = _; pos} -> (
      let {expr=_; ty = init_ty} = trans_expr venv tenv init in 
      let _ =
        match typ with
        | None -> (
          match init_ty with 
          | Types.Nil -> Error_msg.error pos "Nil initializer in expression must be constrained by record type";
          | _ -> ()
        ) 
        | Some(name, type_pos) -> (
            match Symbol.look name tenv with
            | None ->
                Error_msg.error type_pos
                  "type constraint in variable declaration does not exist"
            | Some dec_ty -> 
              if Types.compatible dec_ty init_ty then () else 
              Error_msg.error type_pos "init type and declaration type incompatible in variable declaration" 
        )
      in
      let venv' = Symbol.enter name (Env.VarEntry {ty=init_ty}) venv in 
      (venv', tenv)
  )
  | _ -> failwith "todo"

and trans_decs venv tenv decs = 
  match decs with 
  | [] -> (venv, tenv)
  | [dec] -> trans_dec venv tenv dec
  | dec::decs -> 
      let venv', tenv' = trans_dec venv tenv dec in 
      trans_decs venv' tenv' decs

let trans_prog expr : unit = ignore (trans_expr Env.base_venv Env.base_tenv expr)
