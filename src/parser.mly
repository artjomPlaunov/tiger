%{
open Absyn

let symbol = Symbol.of_string
let pos n = Parsing.rhs_start n
let escape () = ref true

let sequence_exp expressions =
  match expressions with
  | [] -> SeqExp []
  | [ (exp, _) ] -> exp
  | _ -> SeqExp expressions

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
%type <Absyn.exp> program
%type <Absyn.exp> exp
%type <Absyn.var> lvalue
%type <Absyn.exp list> args
%type <(Absyn.symbol * Absyn.exp * Absyn.pos) list> record_fields
%type <(Absyn.exp * Absyn.pos) list> expseq
%type <(Absyn.exp * Absyn.pos) list> seq
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
  exp EOF { $1 }

exp:
  NIL { NilExp }
| BREAK { BreakExp (pos 1) }
| INT { IntExp $1 }
| STRING { StringExp ($1, pos 1) }
| MINUS exp %prec UMINUS {
    OpExp { left = IntExp 0; oper = MinusOp; right = $2; pos = pos 1 }
  }
| exp PLUS exp { OpExp { left = $1; oper = PlusOp; right = $3; pos = pos 2 } }
| exp MINUS exp { OpExp { left = $1; oper = MinusOp; right = $3; pos = pos 2 } }
| exp TIMES exp { OpExp { left = $1; oper = TimesOp; right = $3; pos = pos 2 } }
| exp DIVIDE exp { OpExp { left = $1; oper = DivideOp; right = $3; pos = pos 2 } }
| exp EQ exp { OpExp { left = $1; oper = EqOp; right = $3; pos = pos 2 } }
| exp NEQ exp { OpExp { left = $1; oper = NeqOp; right = $3; pos = pos 2 } }
| exp LT exp { OpExp { left = $1; oper = LtOp; right = $3; pos = pos 2 } }
| exp LE exp { OpExp { left = $1; oper = LeOp; right = $3; pos = pos 2 } }
| exp GT exp { OpExp { left = $1; oper = GtOp; right = $3; pos = pos 2 } }
| exp GE exp { OpExp { left = $1; oper = GeOp; right = $3; pos = pos 2 } }
| exp AND exp {
    IfExp { test = $1; then_ = $3; else_ = Some (IntExp 0); pos = pos 2 }
  }
| exp OR exp {
    IfExp { test = $1; then_ = IntExp 1; else_ = Some $3; pos = pos 2 }
  }
| ID LPAREN RPAREN { CallExp { func = symbol $1; args = []; pos = pos 1 } }
| ID LPAREN args RPAREN { CallExp { func = symbol $1; args = $3; pos = pos 1 } }
| ID LBRACE RBRACE { RecordExp { fields = []; typ = symbol $1; pos = pos 1 } }
| ID LBRACE record_fields RBRACE { RecordExp { fields = $3; typ = symbol $1; pos = pos 1 } }
| ID LBRACK exp RBRACK OF exp %prec OF {
    ArrayExp { typ = symbol $1; size = $3; init = $6; pos = pos 1 }
  }
| lvalue ASSIGN exp { AssignExp { var = $1; exp = $3; pos = pos 2 } }
| lvalue %prec LVALUE { VarExp $1 }
| IF exp THEN exp %prec THEN { IfExp { test = $2; then_ = $4; else_ = None; pos = pos 1 } }
| IF exp THEN exp ELSE exp { IfExp { test = $2; then_ = $4; else_ = Some $6; pos = pos 1 } }
| WHILE exp DO exp %prec DO { WhileExp { test = $2; body = $4; pos = pos 1 } }
| FOR ID ASSIGN exp TO exp DO exp %prec DO {
    ForExp { var = symbol $2; escape = escape (); lo = $4; hi = $6; body = $8; pos = pos 1 }
  }
| LET decs IN expseq END { LetExpr { decs = $2; body = sequence_exp $4; pos = pos 1 } }
| LPAREN expseq RPAREN { sequence_exp $2 }

lvalue:
  ID { SimpleVar (symbol $1, pos 1) }
| ID LBRACK exp RBRACK { SubscriptVar (SimpleVar (symbol $1, pos 1), $3, pos 2) }
| lvalue DOT ID { FieldVar ($1, symbol $3, pos 2) }
| lvalue LBRACK exp RBRACK { SubscriptVar ($1, $3, pos 2) }

args:
  exp { [ $1 ] }
| exp COMMA args { $1 :: $3 }

record_fields:
  ID EQ exp { [ (symbol $1, $3, pos 1) ] }
| ID EQ exp COMMA record_fields { (symbol $1, $3, pos 1) :: $5 }

expseq:
  { [] }
| seq { $1 }

seq:
  exp { [ ($1, pos 1) ] }
| exp SEMICOLON seq { ($1, pos 1) :: $3 }

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
  VAR ID ASSIGN exp {
    VarDec { name = symbol $2; escape = escape (); typ = None; init = $4; pos = pos 1 }
  }
| VAR ID COLON ID ASSIGN exp {
    VarDec {
      name = symbol $2;
      escape = escape ();
      typ = Some (symbol $4, pos 4);
      init = $6;
      pos = pos 1;
    }
  }

fundec:
  FUNCTION ID LPAREN tyfields RPAREN EQ exp {
    FunctionDec [ { name = symbol $2; params = $4; result = None; body = $7; pos = pos 1 } ]
  }
| FUNCTION ID LPAREN tyfields RPAREN COLON ID EQ exp {
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
