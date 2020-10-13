%{
#include <string.h>
#include "util.h"
#include "tokens.h"
#include "errormsg.h"


#define MAX_STR_CONST 2048
int charPos=1;


int yywrap(void)
{
        charPos=1;
        return 1;
}


void adjust(void)
{
        EM_tokPos=charPos;
        charPos+=yyleng;
}

%}

%x str 
%x comment
id      [a-zA-Z][a-zA-Z_0-9]*
ws      [ \t\r\f]

%%
        char string_buf[MAX_STR_CONST];        
        string string_buf_ptr;

\" {
        adjust();
        string_buf_ptr = string_buf; 
        BEGIN(str);
}

"/*" {
        adjust();
        BEGIN(comment);
}


{ws}	        {adjust(); continue;}
\n	        {adjust(); EM_newline(); continue;}
","	        {adjust(); return COMMA;}
":"             {adjust(); return COLON;}
";"             {adjust(); return SEMICOLON;}
"("             {adjust(); return LPAREN;}
")"             {adjust(); return RPAREN;}
"["             {adjust(); return LBRACK;}
"]"             {adjust(); return RBRACK;} 
"{"             {adjust(); return LBRACE;}
"}"             {adjust(); return RBRACE;}
"."             {adjust(); return DOT;}
"-"             {adjust(); return MINUS;}
"+"             {adjust(); return PLUS;}
"*"             {adjust(); return TIMES;}
"/"             {adjust(); return DIVIDE;}
"="             {adjust(); return EQ;}
"<>"            {adjust(); return NEQ;} 
"<"             {adjust(); return LT;}
"<="            {adjust(); return LE;}
">"             {adjust(); return GT;}
">="            {adjust(); return GE;}
"&"             {adjust(); return AND;}
"|"             {adjust(); return OR;}
":="            {adjust(); return ASSIGN;}
array           {adjust(); return ARRAY;}
if              {adjust(); return IF;}
then            {adjust(); return THEN;} 
else            {adjust(); return ELSE;}
while           {adjust(); return WHILE;}
for  	        {adjust(); return FOR;}
to              {adjust(); return TO;}
do              {adjust(); return DO;}
let             {adjust(); return LET;}
in              {adjust(); return IN;}
end             {adjust(); return END;}
of              {adjust(); return OF;}
break           {adjust(); return BREAK;}
nil             {adjust(); return NIL;}
function        {adjust(); return FUNCTION;}
var             {adjust(); return VAR;}
type            {adjust(); return TYPE;}
{id}            {adjust(); yylval.sval=yytext; return ID;}
[0-9]+  	{adjust(); yylval.ival=atoi(yytext); return INT;}
.	        {adjust(); EM_error(EM_tokPos,"illegal token");}

<comment>[^*\n]* {
        /* eat anything that's not a '*' */
        adjust();
}

<comment>"*"+[^*/\n]* {  
        /* eat up '*'s not followed by '/'s */
        adjust();
}

<comment>\n {
        adjust();
        EM_newline();
}

<comment>"*"+"/" {       
        adjust();
        BEGIN(INITIAL);
}

<str>\" { 
        /* saw closing quote - all done. */ 
        adjust();
        BEGIN(INITIAL); 
        *string_buf_ptr = '\0';
        yylval.sval = string_buf;
        return STRING;
} 

<str>\n {
        adjust();
        EM_error(EM_tokPos,"unterminated string constant");
        return 0; 
}

<str>\\[0-7]{1,3} {
        adjust();
        /* octal escape sequence */ 
        int result;

        (void) sscanf( yytext + 1, "%o", &result );

        if ( result > 0xff )
                EM_error(EM_tokPos, "constant is out-of-bounds");
                return 0; 
                /* error, constant is out-of-bounds */

        *string_buf_ptr++ = result;
}

<str>\\[0-9]+ {
        adjust();
        /* generate error - bad escape sequence; something
        * like '\48' or '\0777777'
        */
        EM_error(EM_tokPos, "bad escape sequence");
        return 0;
}

<str>\\n  {adjust(); *string_buf_ptr++ = '\n';}
<str>\\t  {adjust(); *string_buf_ptr++ = '\t';}
<str>\\r  {adjust(); *string_buf_ptr++ = '\r';}
<str>\\b  {adjust(); *string_buf_ptr++ = '\b';}
<str>\\f  {adjust(); *string_buf_ptr++ = '\f';}

<str>\\(.|\n)  {
        adjust(); 
        *string_buf_ptr++ = yytext[1];
}

<str>[^\\\n\"]+ {
        adjust();
        char *yptr = yytext;

        while ( *yptr )
                *string_buf_ptr++ = *yptr++;
}

