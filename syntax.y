%{

    #include <stdio.h>
    #include <stdlib.h>    
    
    extern FILE *yyin;
    extern int yylex();    
%}

%union {
int intval;
char *strval;
}

//keywords apo ekfwnhsh    termatikoi xarakthres
// ta types mporei na vgoun (xreiazontai sth shmasiologikh analush)
// isws xreiastei na pros8e8oun ari8moi sta tokens 
%token <strval>    T_PROGRAM            "program start"
%token <strval>    T_FUNCTION           "function"
%token <strval>    T_VARS               "variables"
%token <strval>    T_CHAR               "char"
%token <intval>    T_INTEGER            "integer"
%token <strval>    T_END_FUNCTION       "end function"
%token <strval>    T_RETURN             "return"
%token <strval>    T_STARTMAIN          "start main"
%token <strval>    T_ENDMAIN            "end main"
%token <strval>    T_WHILE              "while"
%token <strval>    T_ENDWHILE           "end while"
%token <strval>    T_FOR                "for"
%token <strval>    T_TO                 "to"
%token <strval>    T_STEP               "step"
%token <strval>    T_ENDFOR             "endfor"
%token <strval>    T_IF                 "if"
%token <strval>    T_THEN               "then"
%token <strval>    T_ELSEIF             "elseif"
%token <strval>    T_ENDIF              "endif"
%token <strval>    T_SWITCH             "switch"
%token <strval>    T_CASE               "case"
%token <strval>    T_DEFAULT            "default"
%token <strval>    T_ENDSWITCH          "endswitch"
%token <strval>    T_BREAK              "break"

// telestes
%token <strval>    T_OROP               "||"
%token <strval>    T_ANDOP              "&&"
%token <strval>    T_EQUOP              "== or !="
%token <strval>    T_RELOP              "> or < or >= or <="
%token <strval>    T_ADDOP              "+ or -"
%token <strval>    T_MULOP              "* or / or ^"

%token <strval>    T_ID                 "id"
%token <strval>    T_DIGIT              "digit"
%token <strval>    T_NUM                "num"
%token <strval>    T_SCONST             "string"
%token <strval>    T_CHARACTER          "character" 

// lexikoi telestes
%token <strval>    T_LPAREN             "("
%token <strval>    T_RPAREN             ")"
%token <strval>    T_SEMI               ";"
%token <strval>    T_COMMA              ","
%token <strval>    T_ASSIGN             "="
%token <strval>    T_LBRACK             "["
%token <strval>    T_RBRACK             "]"
%token <strval>    T_LBRACE             "{"
%token <strval>    T_RBRACE             "}"
%token <strval>    T_DDOT               ":"

%token T_EOF       0                    "EOF"


%%

main_header:  T_INTEGER T_STARTMAIN T_LPAREN T_RPAREN;

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

    yyparse();

    fclose(yyin);
    return 0;
}
