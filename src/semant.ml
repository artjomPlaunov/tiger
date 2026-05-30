open Absyn

type venv = Env.enventry Symbol.table
type tenv = Types.ty Symbol.table
type expty = { exp : Translate.exp; ty : Types.ty }

let check_int ({ ty; _ } : expty) pos =
  match ty with
  | Types.Int -> ()
  | _ -> Error_msg.error pos "integer required"

let trans_exp venv _tenv exp =
  let rec tr_exp exp =
    match exp with
    | VarExp var -> tr_var var
    | NilExp -> { exp = (); ty = Types.Nil }
    | IntExp _ -> { exp = (); ty = Types.Int }
    | StringExp (_, _) -> { exp = (); ty = Types.String }
    | OpExp { left; oper; right; pos } -> tr_op left oper right pos
    | CallExp { func; args; pos } -> tr_call func args pos
    | _ -> failwith "todo"
  and tr_call func args pos =
    match Symbol.look func venv with
    | Some (Env.FunEntry { formals; result }) ->
        check_args pos formals args;
        { exp = (); ty = Types.actual result }
    | Some (Env.VarEntry _) ->
        Error_msg.error pos "variable used as function";
        { exp = (); ty = Types.Int }
    | None ->
        Error_msg.error pos "undefined function";
        { exp = (); ty = Types.Int }
  and tr_var var =
    match var with
    | SimpleVar (name, pos) -> (
        match Symbol.look name venv with
        | Some (Env.VarEntry { ty }) -> { exp = (); ty = Types.actual ty }
        | Some (Env.FunEntry _) ->
            Error_msg.error pos "function used as variable";
            { exp = (); ty = Types.Int }
        | None ->
            Error_msg.error pos "undefined variable";
            { exp = (); ty = Types.Int })
    | _ -> failwith "todo"
  and tr_op left oper right pos =
    let left_expty = tr_exp left in
    let right_expty = tr_exp right in
    match oper with
    | PlusOp | MinusOp | TimesOp | DivideOp ->
        check_int left_expty pos;
        check_int right_expty pos;
        { exp = (); ty = Types.Int }
    | EqOp | NeqOp ->
        if Types.compatible left_expty.ty right_expty.ty then
          { exp = (); ty = Types.Int }
        else (
          Error_msg.error pos "same type required";
          { exp = (); ty = Types.Int })
    | LtOp | LeOp | GtOp | GeOp -> (
        match (Types.actual left_expty.ty, Types.actual right_expty.ty) with
        | Types.Int, Types.Int
        | Types.String, Types.String ->
            { exp = (); ty = Types.Int }
        | _ ->
            Error_msg.error pos "integer or string required";
            { exp = (); ty = Types.Int })
  and check_args pos formals args =
    match (formals, args) with
    | [], [] -> ()
    | [], extra_args ->
        List.iter (fun arg -> ignore (tr_exp arg)) extra_args;
        Error_msg.error pos "too many arguments"
    | _ :: _, [] -> Error_msg.error pos "too few arguments"
    | formal :: formals, arg :: args ->
        let arg_expty = tr_exp arg in
        if not (Types.compatible formal arg_expty.ty) then
          Error_msg.error pos "argument type mismatch";
        check_args pos formals args
  in
  tr_exp exp

let trans_prog exp : unit = ignore (trans_exp Env.base_venv Env.base_tenv exp)
