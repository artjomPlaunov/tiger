type venv = Env.enventry Symbol.table
type tenv = Types.ty Symbol.table
type expty

val transExp : venv * tenv * Absyn.exp -> expty

(* val transVar : venv * tenv * Absyn.var -> expty *)