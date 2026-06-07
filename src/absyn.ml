type pos = int
type symbol = Symbol.t

type var =
  | SimpleVar of symbol * pos
  | FieldVar of var * symbol * pos
  | SubscriptVar of var * expr * pos

and expr =
  | VarExpr of var
  | NilExpr
  | IntExpr of int
  | StringExpr of string * pos
  | CallExpr of { func : symbol; args : expr list; pos : pos }
  | OpExpr of { left : expr; oper : oper; right : expr; pos : pos }
  | RecordExpr of { fields : (symbol * expr * pos) list; typ : symbol; pos : pos }
  | SeqExpr of (expr * pos) list
  | AssignExpr of { var : var; expr : expr; pos : pos }
  | IfExpr of { test : expr; then_ : expr; else_ : expr option; pos : pos }
  | WhileExpr of { test : expr; body : expr; pos : pos }
  | ForExpr of {
      var : symbol;
      escape : bool ref;
      lo : expr;
      hi : expr;
      body : expr;
      pos : pos;
    }
  | BreakExpr of pos
  | LetExpr of { decs : dec list; body : expr; pos : pos }
  | ArrayExpr of { typ : symbol; size : expr; init : expr; pos : pos }

and dec =
  | FunctionDec of fundec list
  | VarDec of {
      name : symbol;
      escape : bool ref;
      typ : (symbol * pos) option;
      init : expr;
      pos : pos;
    }
  | TypeDec of typedec list

and ty =
  | NameTy of symbol * pos
  | RecordTy of field list
  | ArrayTy of symbol * pos

and oper =
  | PlusOp
  | MinusOp
  | TimesOp
  | DivideOp
  | EqOp
  | NeqOp
  | LtOp
  | LeOp
  | GtOp
  | GeOp

and field = {
  name : symbol;
  escape : bool ref;
  typ : symbol;
  pos : pos;
}

and fundec = {
  name : symbol;
  params : field list;
  result : (symbol * pos) option;
  body : expr;
  pos : pos;
}

and typedec = {
  name : symbol;
  ty : ty;
  pos : pos;
}
