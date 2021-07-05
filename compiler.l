%{
    
#include <stdio.h>
#include <stdlib.h>
#include "compiler.h"

char str_buf[256];

void TPRINT(int token_id);
//int lineno=1;

%}
%option noyywrap
%option yylineno

%x SINGLE_LINE_COMMENT
%x STRING
/*metraei se poia grammh eimaste 
/* %option yylineno  */
/* dhlwseis klasewn twn RegEX pou tha xrhsimopoihsoume pio katw */ 
CHARACTER     [a-zA-Z]
DIGIT         [0-9]
ALPHANUM      ({CHARACTER}|{DIGIT})
ALPHANUM_     ({ALPHANUM}|_)
NUMBER        [1-9][0-9]*|0
IDENTIFIER    \_*{CHARACTER}{ALPHANUM}*(_{ALPHANUM}+)*_?
WHITESPACE    [ \t]


%%
                  /*yylval.strval = strdup(yytext)*/
"PROGRAM"           { TPRINT(T_PROGRAM); return T_PROGRAM; }
"FUNCTION"          { TPRINT(T_FUNCTION); return T_FUNCTION; }
"VARS"              { TPRINT(T_VARS); return T_VARS; }
"CHAR"              { TPRINT(T_CHAR); return T_CHAR; }
"INTEGER"           { TPRINT(T_INTEGER); return T_INTEGER; }
"END_FUNCTION"      { TPRINT(T_END_FUNCTION); return T_END_FUNCTION; }
"RETURN"            { TPRINT(T_RETURN); return T_RETURN;}
"STARTMAIN"         { TPRINT(T_STARTMAIN); return T_STARTMAIN; }
"ENDMAIN"           { TPRINT(T_ENDMAIN); return T_ENDMAIN; }
"WHILE"             { TPRINT(T_WHILE); return T_WHILE; }
"ENDWHILE"          { TPRINT(T_ENDWHILE); return T_ENDWHILE; }
"FOR"               { TPRINT(T_FOR); return T_FOR; }
"TO"                { TPRINT(T_TO); return T_TO; }
"STEP"              { TPRINT(T_STEP); return T_STEP;}
"ENDFOR"            { TPRINT(T_ENDFOR); return T_ENDFOR; }
"IF"                { TPRINT(T_IF); return T_IF;}
"THEN"              { TPRINT(T_THEN); return T_THEN;}
"ELSEIF"            { TPRINT(T_ELSEIF); return T_ELSEIF; }
"ENDIF"             { TPRINT(T_ENDIF); return T_ENDIF; }
"SWITCH"            { TPRINT(T_SWITCH); return T_SWITCH;}
"CASE"              { TPRINT(T_CASE); return T_CASE; }
"DEFAULT"           { TPRINT(T_DEFAULT); return T_DEFAULT; }
"ENDSWITCH"         { TPRINT(T_ENDSWITCH); return T_ENDSWITCH; }
"BREAK"             { TPRINT(T_BREAK); return T_BREAK; }

{IDENTIFIER}        { TPRINT(T_ID); return T_ID;}
{DIGIT}             { TPRINT(T_DIGIT); return T_DIGIT;}
{NUMBER}            { TPRINT(T_NUM); return T_NUM;}

"%"                                 {printf("Comment Found\n");BEGIN(SINGLE_LINE_COMMENT);}
<SINGLE_LINE_COMMENT>(\n|\r\n)      {BEGIN(INITIAL); printf("Comment ended\n");}
<SINGLE_LINE_COMMENT>.              { }

\"                                  {strcpy(str_buf,""); BEGIN(STRING);}
<STRING>\"                          {BEGIN(INITIAL); printf("found string '%s' \n", str_buf); return T_SCONST;}
<STRING>\\\n|\\\r\n                 {printf("Note"); } 
<STRING>\\.|[^"\\]  {  
    if(strlen(yytext) ==2) { 
        if(strcmp(yytext, "\\n")) {
            strcat(str_buf, "\n");
        } else if (strcmp(yytext, "t")){
            strcat(str_buf, "\t");
        }
     } else {
        strcat(str_buf, yytext);
    }
     }
<STRING>\n|\r\n                     {printf("new line found without \\ \n");}
<STRING><<EOF>>                     {printf("end of string without closing it \n");}
<STRING>.                           {printf("Unknown charak. \n");}

"||"                {TPRINT(T_OROP); return T_OROP;}
"&&"                {TPRINT(T_ANDOP); return T_ANDOP;}
"==" | "!="         {TPRINT(T_EQUOP); return T_EQUOP;}
">"|"<"|">="|"<="   {TPRINT(T_RELOP); return T_RELOP;}
"+"|"-"             {TPRINT(T_ADDOP); return T_ADDOP;}
"*"|"/"|"^"         {TPRINT(T_MULOP); return T_MULOP;}




"("                 {TPRINT(T_LPAREN); return T_LPAREN;}
")"                 {TPRINT(T_RPAREN); return T_RPAREN;}
";"                 {TPRINT(T_SEMI); return T_SEMI;}
","                 {TPRINT(T_COMMA); return T_COMMA;}
"="                 {TPRINT(T_ASSIGN); return T_ASSIGN;}
"["                 {TPRINT(T_LBRACK); return T_LBRACK;}
"]"                 {TPRINT(T_RBRACK); return T_RBRACK;}
"{"                 {TPRINT(T_LBRACE); return T_LBRACE;}
"}"                 {TPRINT(T_RBRACE); return T_RBRACE;}

{WHITESPACE}        { }
\n                  {yylineno;}
\r\n                {  }


.                   {printf("Unknown\n");}
<<EOF>>             { TPRINT(T_EOF); return T_EOF;}

%%

int main(int argc, char *argv[]){
    int token;
    if(argc >1){
        yyin=fopen(argv[1], "r");
        if (yyin == NULL){
            perror ("Error opening file");
            return -1;
        }
    }

    do{
        token =yylex();
    }
    while(token!=0);
    fclose(yyin);
    yyterminate();


}

void TPRINT(int token_id){
    printf("TOKEN FOUND : %s | TOKEN NUMBER: %d |LINE: %d\n", yytext, token_id, yylineno);
}