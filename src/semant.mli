type venv = Env.enventry Symbol.table
type tenv = Types.ty Symbol.table
type expr_ty = { expr : Translate.exp; ty : Types.ty }

val trans_prog : Absyn.exp -> unit

val trans_expr : venv -> tenv -> Absyn.exp -> expr_ty
val trans_dec : venv -> tenv -> Absyn.dec -> venv * tenv

(* val trans_var : venv -> tenv -> Absyn.var -> expr_ty *)
