open Absyn

type venv = Env.enventry Symbol.table
type tenv = Types.ty Symbol.table
type expty = { exp : Translate.exp; ty : Types.ty }

let check_int ({ ty; _ } : expty) pos =
  match ty with
  | Types.Int -> ()
  | _ -> Error_msg.error pos "integer required"

let transExp _venv _tenv exp =
  let rec trexp exp =
    match exp with
  
    | NilExp -> { exp = (); ty = Types.Nil }
    | IntExp _ -> { exp = (); ty = Types.Int }
    | StringExp (_, _) -> { exp = (); ty = Types.String }
    | OpExp { left; oper; right; pos } ->
        let left_expty = trexp left in
        let right_expty = trexp right in
        (match oper with
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
                { exp = (); ty = Types.Int }))
    | _ -> failwith "todo"
  in
  trexp exp

let transProg exp : unit = ignore (transExp Env.base_venv Env.base_tenv exp)
