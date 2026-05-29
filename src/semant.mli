type venv = Env.enventry Symbol.table
type tenv = Types.ty Symbol.table
type expty = { exp : Translate.exp; ty : Types.ty }

val transProg : Absyn.exp -> unit

val transExp : venv -> tenv -> Absyn.exp -> expty

(* val transVar : venv -> tenv -> Absyn.var -> expty *)
