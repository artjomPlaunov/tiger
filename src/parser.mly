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
%type <unit> program
%type <unit> exp
%type <unit> lvalue
%type <unit> args
%type <unit> record_fields
%type <unit> seq

%%

program:
  exp EOF { () }

exp:
  NIL { () }
| INT { () }
| STRING { () }
| MINUS exp %prec UMINUS { () }
| exp PLUS exp { () }
| exp MINUS exp { () }
| exp TIMES exp { () }
| exp DIVIDE exp { () }
| exp EQ exp { () }
| exp NEQ exp { () }
| exp LT exp { () }
| exp LE exp { () }
| exp GT exp { () }
| exp GE exp { () }
| exp AND exp { () }
| exp OR exp { () }
| ID LPAREN RPAREN { () }
| ID LPAREN args RPAREN { () }
| ID LBRACE RBRACE { () }
| ID LBRACE record_fields RBRACE { () }
| ID LBRACK exp RBRACK OF exp %prec OF { () }
| lvalue ASSIGN exp { () }
| lvalue %prec LVALUE { () }
| IF exp THEN exp %prec THEN { () }
| IF exp THEN exp ELSE exp { () }
| WHILE exp DO exp %prec DO { () }
| LPAREN RPAREN { () }
| LPAREN exp RPAREN { () }
| LPAREN exp SEMICOLON seq RPAREN { () }

lvalue:
  ID { () }
| ID LBRACK exp RBRACK { () }
| lvalue DOT ID { () }
| lvalue LBRACK exp RBRACK { () }

args:
  exp { () }
| exp COMMA args { () }

record_fields:
  ID EQ exp { () }
| ID EQ exp COMMA record_fields { () }

seq:
  exp { () }
| exp SEMICOLON seq { () }
