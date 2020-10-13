%{
#include <stdio.h>
#include "util.h"
#include "errormsg.h"

int yylex(void); /* function prototype */

void yyerror(char *s)
{
        EM_error(EM_tokPos, "%s", s);
}
%}


%union {
	int pos;
	int ival;
	char * sval;
	}

%token <sval> ID STRING
%token <ival> INT

%token 
        COMMA COLON SEMICOLON LPAREN RPAREN LBRACK RBRACK 
        LBRACE RBRACE DOT 
        PLUS MINUS TIMES DIVIDE EQ NEQ LT LE GT GE
        AND OR ASSIGN
        ARRAY IF THEN ELSE WHILE FOR TO DO LET IN END OF 
        BREAK NIL
        FUNCTION VAR TYPE 
        UMINUS


%nonassoc THEN
%nonassoc DO OF ELSE IN
%nonassoc ASSIGN
%nonassoc OR
%nonassoc AND
%nonassoc EQ NEQ LT GT GEQ LEQ 
%left PLUS MINUS
%left TIMES DIVIDE
%nonassoc UMINUS

%start program

%%

program: exp 

decs:
        LBRACE dec RBRACE

dec:
        ty_dec
|       var_dec
|       fun_dec

ty_dec:
        ty ID EQ ty

ty:
        ID
|       LBRACE ty_fields RBRACE
|       ARRAY OF ID 

ty_fields:
        ID COLON ID LBRACE RBRACE
|       ID COLON ID LBRACE ty_decl_list RBRACE

ty_decl_list:
        ty_decl
|       ty_decl_list COMMA ty_decl

ty_decl:
        ID COLON ID

var_dec:
        VAR ID ASSIGN exp
|       VAR ID COLON ID ASSIGN exp

fun_dec:
        FUNCTION ID LPAREN ty_fields RPAREN EQ exp
|       FUNCTION ID LPAREN ty_fields RPAREN COLON ID EQ exp

l_val:
        ID
|       l_val DOT ID
|       l_val LBRACK exp RBRACK


exp:
        seq_exp
|       l_val 
|       NIL
|       INT
|       STRING
|       UMINUS exp
|       fun_call 
|       exp PLUS exp
|       exp MINUS exp
|       exp TIMES exp
|       exp DIVIDE exp
|       exp EQ exp
|       exp NEQ exp
|       exp GT exp
|       exp LT exp
|       exp GEQ exp
|       exp LEQ exp
|       exp AND exp
|       exp OR exp
|       ID LBRACE RBRACE
|       ID LBRACE decl_lst RBRACE
        /* Perform check to make sure l_val is an ID */
|       l_val LBRACK exp RBRACK OF exp
|       l_val ASSIGN exp
|       IF exp THEN exp ELSE exp
|       IF exp THEN exp
|       WHILE exp DO exp
|       FOR ID ASSIGN exp TO exp DO exp
|       BREAK
|       LET decs IN seq_exp

seq_exp:
        LPAREN RPAREN
|       LPAREN exp_lst RPAREN

exp_lst:
        exp 
|       exp_lst SEMICOLON exp

fun_call:
        ID LPAREN RPAREN
|       ID LPAREN arg_lst RPAREN

arg_lst:
        exp
|       arg_lst COMMA exp 

decl:
        ID EQ exp        

decl_lst:
        decl
|       decl_lst COMMA decl
