type access
type ty = Types.ty

type enventry =
  | VarEntry of { ty : ty }
  | FunEntry of { formals : ty list; result : ty }

val base_venv : enventry Symbol.table
val base_tenv : ty Symbol.table
