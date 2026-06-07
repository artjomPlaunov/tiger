type venv = Env.enventry Symbol.table
type tenv = Types.ty Symbol.table
type expr_ty = { expr : Translate.expr; ty : Types.ty }

val trans_prog : Absyn.expr -> unit

val trans_expr : venv -> tenv -> Absyn.expr -> expr_ty
val trans_dec : venv -> tenv -> Absyn.dec -> venv * tenv

(* val trans_var : venv -> tenv -> Absyn.var -> expr_ty *)
