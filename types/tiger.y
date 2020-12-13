%{
#include <stdio.h>
#include <stdlib.h>
#include "absyn.h"
#include "util.h"
#include "symbol.h"
#include "errormsg.h"

int yylex(void); /* function prototype */

A_exp absyn_root;

void yyerror(char *s)
{
        EM_error(EM_tokPos, "%s", s);
}
%}


%union {
    int             ival;
    char *          sval;
    A_exp           exp;
    A_var           var;
    A_pos           pos;
    A_expList       arg_lst;
    A_expList       exp_lst;
    A_efield        efield;
    A_efieldList    efield_lst;
    A_decList       dec_lst;
    A_dec           dec;
    A_ty            ty;
    A_nametyList    namety_lst;
    A_namety        namety;
    A_field         field;
    A_fieldList     field_lst;
    A_fundecList    fun_dec_lst;
    A_fundec        fun_dec;
    }

%token <sval> ID STRING
%token <ival> INT

%token 
        COMMA COLON SEMICOLON LPAREN RPAREN LBRACK RBRACK 
        LBRACE RBRACE DOT 
        PLUS MINUS TIMES DIVIDE EQ NEQ LT GT LE GE
        AND OR ASSIGN
        ARRAY IF THEN ELSE WHILE FOR TO DO LET IN END OF 
        BREAK NIL
        FUNCTION VAR TYPE 
        UMINUS


%nonassoc       THEN
%nonassoc       DO OF ELSE IN
%nonassoc       ASSIGN
%left       OR
%left       AND
%nonassoc       EQ NEQ LT GT GE LE 
%left           PLUS MINUS
%left           TIMES DIVIDE
%nonassoc       UMINUS

%type <exp>             program
%type <pos>             pos
%type <exp>             exp
%type <var>             l_val
%type <exp>             fun_call
%type <exp>             seq_exp
%type <arg_lst>         arg_lst       
%type <efield>          efield
%type <efield_lst>      efield_lst
%type <exp_lst>         exp_lst
%type <dec_lst>         dec_lst
%type <dec_lst>         decs
%type <dec>             dec
%type <namety_lst>      namety_lst
%type <namety>          namety
%type <ty>              ty
%type <field>           field
%type <field_lst>       field_lst
%type <fun_dec_lst>     fun_dec_lst
%type <fun_dec>         fun_dec

%start program

%%

program: exp { absyn_root = $1; }

pos :   { $$ = EM_tokPos; }

decs:   { 
                $$ = NULL; 
        }
|       dec_lst {
                $$ = $1; 
        }

dec_lst:
        dec {
                $$ = A_DecList($1, NULL);
        }
|       dec dec_lst {
                $$ = A_DecList($1, $2);
        }

dec:
        namety_lst {
                $$ = A_TypeDec(EM_tokPos, $1);
        }
|       VAR pos ID ASSIGN exp {
                $$ = A_VarDec($2, S_Symbol($3), NULL, $5);
        }
|       VAR pos ID COLON ID ASSIGN exp {
                $$ = A_VarDec($2, S_Symbol($3), S_Symbol($5), $7);
        }
|       fun_dec_lst {
                $$ = A_FunctionDec(EM_tokPos, $1);
        }

fun_dec_lst:
        fun_dec {
                $$ = A_FundecList($1, NULL);
        }
|       fun_dec fun_dec_lst {
                $$ = A_FundecList($1, $2);
}

fun_dec:
        FUNCTION ID LPAREN RPAREN EQ exp {
                $$ = A_Fundec(EM_tokPos, S_Symbol($2), NULL, NULL, $6);
        }
|       FUNCTION ID LPAREN field_lst RPAREN EQ exp {
                $$ = A_Fundec(EM_tokPos, S_Symbol($2), $4, NULL, $7);
        }
|       FUNCTION ID LPAREN RPAREN COLON ID EQ exp {
                $$ = A_Fundec(EM_tokPos, S_Symbol($2), NULL, S_Symbol($6), $8);
        }
|       FUNCTION ID LPAREN field_lst RPAREN COLON ID EQ exp {
                $$ = A_Fundec(EM_tokPos, S_Symbol($2), $4, 
                                S_Symbol($7), $9);
        }


/* Shift reduce conflct in state "namety . namety_lst" when the token 
   TYPE is seen next on the input. 

   Default action on conflict is to shift, which is (I think) acceptable 
   since the parser should not reduce to a namety_lst when there are still 
   namety's left (as there will be due to the TYPE token). */
namety_lst: 
        namety {
                $$ = A_NametyList($1, NULL);
        }
|       namety namety_lst {
                $$ = A_NametyList($1, $2);
        }

namety: 
        TYPE ID EQ ty {
                $$ = A_Namety(S_Symbol($2), $4);
        }

ty:
        ID {
                $$ = A_NameTy(EM_tokPos, S_Symbol($1));
        }
|       LBRACE RBRACE {
                $$ = A_RecordTy(EM_tokPos, NULL);
        }
|       LBRACE field_lst RBRACE {
                $$ = A_RecordTy(EM_tokPos, $2);
        }
|       ARRAY OF ID {
                $$ = A_ArrayTy(EM_tokPos, S_Symbol($3));
        }

field_lst:
        field {
                $$ = A_FieldList($1, NULL);
        }
|       field COMMA field_lst {
                $$ = A_FieldList($1, $3);
        }

field:
        ID COLON ID {
                $$ = A_Field(EM_tokPos, S_Symbol($1), S_Symbol($3));
        }
        
l_val:
        ID pos {
                $$ = A_SimpleVar($2, S_Symbol($1));

        }
|       l_val DOT pos ID {
                $$ = A_FieldVar($3, $1, S_Symbol($4));
        }
|       l_val LBRACK exp  RBRACK {
                $$ = A_SubscriptVar(EM_tokPos, $1, $3);
        }
exp:
        l_val { 
                $$ = A_VarExp(EM_tokPos, $1);
        }
|       NIL pos {
                $$ = A_NilExp($2);
        }
|       INT pos {
                $$ = A_IntExp($2, $1);
        }
|       STRING pos {
                $$ = A_StringExp($2, $1);
        }
|       UMINUS pos exp {
                $$ = A_OpExp( $2, A_minusOp, A_IntExp($2,0), $3);
        }
|       fun_call {
                $$ = $1; 
        }
|       exp PLUS pos exp {
                $$ = A_OpExp( $3, A_plusOp, $1, $4);
        }
|       exp MINUS pos exp {
                $$ = A_OpExp( $3, A_minusOp,$1,$4);
        }
|       exp TIMES pos exp {
                $$ = A_OpExp($3, A_timesOp, $1, $4);
        }
|       exp DIVIDE pos exp {
                $$ = A_OpExp($3, A_divideOp, $1, $4);
        }
|       exp EQ pos exp {
                $$ = A_OpExp($3, A_eqOp, $1, $4);
        }
|       exp NEQ pos exp {
                $$ = A_OpExp($3, A_neqOp, $1, $4);
        }
|       exp GT pos exp {
                $$ = A_OpExp($3, A_gtOp, $1, $4);
        }
|       exp LT pos exp {
                $$ = A_OpExp($3, A_ltOp, $1, $4);
        }
|       exp GE pos exp {
                $$ = A_OpExp($3, A_geOp, $1, $4);
        }
|       exp LE pos exp {
                $$ = A_OpExp($3, A_leOp, $1, $4);
        }
|       exp AND pos exp {
                $$ = A_OpExp($3, A_andOp, $1, $4);
                        
        }
|       exp OR pos exp {
                $$ = A_OpExp($3, A_orOp, $1, $4);
        }
|       ID LBRACE pos RBRACE {
                $$ = A_RecordExp( $3, S_Symbol($1), NULL);
        }
|       ID LBRACE pos efield_lst RBRACE {
                $$ = A_RecordExp($3, S_Symbol($1), $4);
}
|       seq_exp { 
                $$ = $1;
        }
        /* Perform check to make sure l_val is an ID */
|       l_val LBRACK exp RBRACK pos OF exp {
                // Check that l_val is a lone identifier. 
                if ($1->kind !=A_simpleVar) {
                        yyerror("Expected id in array creation.");
                        exit(0);
                }
                
                $$ = A_ArrayExp($5,$1->u.simple,$3,$7);
        }
|       l_val ASSIGN pos exp {
                $$ = A_AssignExp($3, $1, $4);
        }
|       IF exp THEN exp ELSE exp {
                $$ = A_IfExp(EM_tokPos, $2, $4, $6);
        }
|       IF exp THEN exp {
                $$ = A_IfExp(EM_tokPos, $2, $4, NULL);
        }
|       WHILE pos exp DO exp {
               $$ = A_WhileExp($2, $3, $5); 
        }
|       FOR pos ID ASSIGN exp TO exp DO exp {
                $$ = A_ForExp($2, S_Symbol($3), $5, $7, $9);
        }
|       BREAK pos {
                $$ = A_BreakExp($2);
        }
|       LET pos decs IN exp_lst END {
                $$ = A_LetExp($2, $3, A_SeqExp(EM_tokPos, $5)); 
        }

seq_exp:
        LPAREN pos RPAREN {
                $$ = A_SeqExp($2, NULL);
        }
|       LPAREN pos exp_lst RPAREN {
                $$ = A_SeqExp($2, $3);
        }

exp_lst:
        exp {
                $$ = A_ExpList($1, NULL);
        }
|       exp SEMICOLON exp_lst {
                $$ = A_ExpList($1, $3);
        }

fun_call:
        ID LPAREN pos RPAREN {
                $$ = A_CallExp($3, S_Symbol($1),NULL);
        }
|       ID LPAREN pos arg_lst RPAREN {
                $$ = A_CallExp($3, S_Symbol($1), $4);
        }

arg_lst:
        exp {
                $$ = A_ExpList($1, NULL);
        }
|       exp COMMA arg_lst {
                $$ = A_ExpList($1, $3);
        }

efield:
        ID EQ exp {
                $$ = A_Efield(S_Symbol($1), $3);
        }

efield_lst:
        efield {
                $$ = A_EfieldList($1, NULL);
        }
|       efield COMMA efield_lst {
                $$ = A_EfieldList($1,$3);
        }
