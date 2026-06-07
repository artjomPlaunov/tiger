%{
open Absyn

let symbol = Symbol.of_string
let pos n = Parsing.rhs_start n
let escape () = ref true

let sequence_expr expressions =
  match expressions with
  | [] -> SeqExpr []
  | [ (expr, _) ] -> expr
  | _ -> SeqExpr expressions

let cons_dec dec decs =
  match dec, decs with
  | TypeDec current, TypeDec rest :: tail -> TypeDec (current @ rest) :: tail
  | FunctionDec current, FunctionDec rest :: tail -> FunctionDec (current @ rest) :: tail
  | _ -> dec :: decs
%}

%token EOF
%token <string> ID
%token <int> INT
%token <string> STRING
%token COMMA COLON SEMICOLON LPAREN RPAREN LBRACK RBRACK
%token LBRACE RBRACE DOT
%token PLUS MINUS TIMES DIVIDE EQ NEQ LT LE GT GE
%token AND OR ASSIGN
%token ARRAY IF THEN ELSE WHILE FOR TO DO LET IN END OF
%token BREAK NIL
%token FUNCTION VAR TYPE

%nonassoc DO
%nonassoc THEN
%nonassoc ELSE
%nonassoc OF
%nonassoc LVALUE
%right ASSIGN
%left OR
%left AND
%nonassoc EQ NEQ LT LE GT GE
%left PLUS MINUS
%left TIMES DIVIDE
%nonassoc UMINUS

%start program
%type <Absyn.expr> program
%type <Absyn.expr> expr
%type <Absyn.var> lvalue
%type <Absyn.expr list> args
%type <(Absyn.symbol * Absyn.expr * Absyn.pos) list> record_fields
%type <(Absyn.expr * Absyn.pos) list> exprseq
%type <(Absyn.expr * Absyn.pos) list> seq
%type <Absyn.dec list> decs
%type <Absyn.dec> dec
%type <Absyn.dec> tydec
%type <Absyn.dec> vardec
%type <Absyn.dec> fundec
%type <Absyn.ty> ty
%type <Absyn.field list> tyfields
%type <Absyn.field list> tyfields_tail

%%

program:
  expr EOF { $1 }

expr:
  NIL { NilExpr }
| BREAK { BreakExpr (pos 1) }
| INT { IntExpr $1 }
| STRING { StringExpr ($1, pos 1) }
| MINUS expr %prec UMINUS {
    OpExpr { left = IntExpr 0; oper = MinusOp; right = $2; pos = pos 1 }
  }
| expr PLUS expr { OpExpr { left = $1; oper = PlusOp; right = $3; pos = pos 2 } }
| expr MINUS expr { OpExpr { left = $1; oper = MinusOp; right = $3; pos = pos 2 } }
| expr TIMES expr { OpExpr { left = $1; oper = TimesOp; right = $3; pos = pos 2 } }
| expr DIVIDE expr { OpExpr { left = $1; oper = DivideOp; right = $3; pos = pos 2 } }
| expr EQ expr { OpExpr { left = $1; oper = EqOp; right = $3; pos = pos 2 } }
| expr NEQ expr { OpExpr { left = $1; oper = NeqOp; right = $3; pos = pos 2 } }
| expr LT expr { OpExpr { left = $1; oper = LtOp; right = $3; pos = pos 2 } }
| expr LE expr { OpExpr { left = $1; oper = LeOp; right = $3; pos = pos 2 } }
| expr GT expr { OpExpr { left = $1; oper = GtOp; right = $3; pos = pos 2 } }
| expr GE expr { OpExpr { left = $1; oper = GeOp; right = $3; pos = pos 2 } }
| expr AND expr {
    IfExpr { test = $1; then_ = $3; else_ = Some (IntExpr 0); pos = pos 2 }
  }
| expr OR expr {
    IfExpr { test = $1; then_ = IntExpr 1; else_ = Some $3; pos = pos 2 }
  }
| ID LPAREN RPAREN { CallExpr { func = symbol $1; args = []; pos = pos 1 } }
| ID LPAREN args RPAREN { CallExpr { func = symbol $1; args = $3; pos = pos 1 } }
| ID LBRACE RBRACE { RecordExpr { fields = []; typ = symbol $1; pos = pos 1 } }
| ID LBRACE record_fields RBRACE { RecordExpr { fields = $3; typ = symbol $1; pos = pos 1 } }
| ID LBRACK expr RBRACK OF expr %prec OF {
    ArrayExpr { typ = symbol $1; size = $3; init = $6; pos = pos 1 }
  }
| lvalue ASSIGN expr { AssignExpr { var = $1; expr = $3; pos = pos 2 } }
| lvalue %prec LVALUE { VarExpr $1 }
| IF expr THEN expr %prec THEN { IfExpr { test = $2; then_ = $4; else_ = None; pos = pos 1 } }
| IF expr THEN expr ELSE expr { IfExpr { test = $2; then_ = $4; else_ = Some $6; pos = pos 1 } }
| WHILE expr DO expr %prec DO { WhileExpr { test = $2; body = $4; pos = pos 1 } }
| FOR ID ASSIGN expr TO expr DO expr %prec DO {
    ForExpr { var = symbol $2; escape = escape (); lo = $4; hi = $6; body = $8; pos = pos 1 }
  }
| LET decs IN exprseq END { LetExpr { decs = $2; body = sequence_expr $4; pos = pos 1 } }
| LPAREN exprseq RPAREN { sequence_expr $2 }

lvalue:
  ID { SimpleVar (symbol $1, pos 1) }
| ID LBRACK expr RBRACK { SubscriptVar (SimpleVar (symbol $1, pos 1), $3, pos 2) }
| lvalue DOT ID { FieldVar ($1, symbol $3, pos 2) }
| lvalue LBRACK expr RBRACK { SubscriptVar ($1, $3, pos 2) }

args:
  expr { [ $1 ] }
| expr COMMA args { $1 :: $3 }

record_fields:
  ID EQ expr { [ (symbol $1, $3, pos 1) ] }
| ID EQ expr COMMA record_fields { (symbol $1, $3, pos 1) :: $5 }

exprseq:
  { [] }
| seq { $1 }

seq:
  expr { [ ($1, pos 1) ] }
| expr SEMICOLON seq { ($1, pos 1) :: $3 }

decs:
  { [] }
| dec decs { cons_dec $1 $2 }

dec:
  tydec { $1 }
| vardec { $1 }
| fundec { $1 }

tydec:
  TYPE ID EQ ty { TypeDec [ { name = symbol $2; ty = $4; pos = pos 1 } ] }

	vardec:
	  VAR ID ASSIGN expr {
	VarDec { name = symbol $2; escape = escape (); typ = None; init = $4; pos = pos 1 }
	  }
	| VAR ID COLON ID ASSIGN expr {
	    VarDec {
	      name = symbol $2;
	      escape = escape ();
	      typ = Some (symbol $4, pos 4);
	      init = $6;
	      pos = pos 1;
	    }
	  }

fundec:
  FUNCTION ID LPAREN tyfields RPAREN EQ expr {
    FunctionDec [ { name = symbol $2; params = $4; result = None; body = $7; pos = pos 1 } ]
  }
| FUNCTION ID LPAREN tyfields RPAREN COLON ID EQ expr {
    FunctionDec [
      {
        name = symbol $2;
        params = $4;
        result = Some (symbol $7, pos 7);
        body = $9;
        pos = pos 1;
      }
    ]
  }

ty:
  ID { NameTy (symbol $1, pos 1) }
| LBRACE tyfields RBRACE { RecordTy $2 }
| ARRAY OF ID { ArrayTy (symbol $3, pos 3) }

	tyfields:
  	{ [] }
	| ID COLON ID tyfields_tail {
	    { name = symbol $1; escape = escape (); typ = symbol $3; pos = pos 1 } :: $4
	  }

	tyfields_tail:
  	{ [] }
	| COMMA ID COLON ID tyfields_tail {
	    { name = symbol $2; escape = escape (); typ = symbol $4; pos = pos 2 } :: $5
	  }
