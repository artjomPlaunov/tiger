type access = unit
type ty = Types.ty
type enventry = 
  | VarEntry of { ty: ty }
  | FunEntry of { formals : ty list; result : ty }

let base_tenv : ty Symbol.table = 
  Symbol.empty 
  |> fun tenv -> Symbol.enter (tenv, Symbol.of_string "int", Types.Int)
  |> fun tenv -> Symbol.enter (tenv, Symbol.of_string "string", Types.String)

let base_venv : enventry Symbol.table = Symbol.empty

