type venv = Env.enventry Symbol.table
type tenv = Types.ty Symbol.table
type expty = { exp : Translate.exp; ty : Types.ty }

val trans_prog : Absyn.exp -> unit

val trans_exp : venv -> tenv -> Absyn.exp -> expty

(* val trans_var : venv -> tenv -> Absyn.var -> expty *)
