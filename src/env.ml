type access = unit
type ty = Types.ty
type enventry = 
  | VarEntry of { ty: ty }
  | FunEntry of { formals : ty list; result : ty }

let base_tenv : ty Symbol.table = 
  Symbol.empty 
  |> fun tenv -> Symbol.enter (tenv, Symbol.of_string "int", Types.Int)
  |> fun tenv -> Symbol.enter (tenv, Symbol.of_string "string", Types.String)

let enter_fun name formals result venv =
  Symbol.enter (venv, Symbol.of_string name, FunEntry { formals; result })

let base_venv : enventry Symbol.table =
  Symbol.empty
  |> enter_fun "print" [ Types.String ] Types.Unit
  |> enter_fun "flush" [] Types.Unit
  |> enter_fun "getchar" [] Types.String
  |> enter_fun "ord" [ Types.String ] Types.Int
  |> enter_fun "chr" [ Types.Int ] Types.String
  |> enter_fun "size" [ Types.String ] Types.Int
  |> enter_fun "substring" [ Types.String; Types.Int; Types.Int ] Types.String
  |> enter_fun "concat" [ Types.String; Types.String ] Types.String
  |> enter_fun "not" [ Types.Int ] Types.Int
  |> enter_fun "exit" [ Types.Int ] Types.Unit
