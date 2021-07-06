%{

    #include <stdio.h>
    #include <stdlib.h>    
    
    extern FILE *yyin;
    extern int yylex();  

    extern int yylineno; 

    int error_counter=0; 

    void yyerror(const char *err);
%}

%define parse.error verbose

%union {
int intval;
char *strval;
}

//keywords apo ekfwnhsh    termatikoi xarakthres
// ta types mporei na vgoun (xreiazontai sth shmasiologikh analush)
// isws xreiastei na pros8e8oun ari8moi sta tokens 
%token     <strval>  T_PROGRAM            "program start"
%token    <strval>  T_FUNCTION           "function"
%token    <strval>  T_VARS               "variables"
%token    <strval>  T_CHAR               "char"
%token   <strval>   T_INTEGER            "integer"
%token   <strval>   T_END_FUNCTION       "end function"
%token    <strval>  T_RETURN             "return"
%token    <strval>  T_STARTMAIN          "start main"
%token   <strval>   T_ENDMAIN            "end main"
%token    <strval>  T_WHILE              "while"
%token    <strval>  T_ENDWHILE           "end while"
%token    <strval>  T_FOR                "for"
%token    <strval>  T_TO                 "to"
%token    <strval>  T_STEP               "step"
%token    <strval>  T_ENDFOR             "endfor"
%token    <strval>  T_IF                 "if"
%token    <strval>  T_THEN               "then"
%token   <strval>   T_ELSEIF             "elseif"
%token    <strval>  T_ELSE               "else"
%token    <strval>  T_ENDIF              "endif"
%token    <strval>  T_SWITCH             "switch"
%token    <strval>  T_CASE               "case"
%token    <strval>  T_DEFAULT            "default"
%token    <strval>  T_ENDSWITCH          "endswitch"
%token    <strval>  T_BREAK              "break"

// telestes
%token    <strval>  T_OROP               "||"
%token    <strval>  T_ANDOP              "&&"
%token   <strval>   T_EQUOP              "== or !="
%token   <strval>   T_RELOP              "> or < or >= or <="
%token   <strval>   T_ADDOP              "+ or -"
%token   <strval>   T_MULOP              "* or / or ^"

%token     <strval>    T_ID     "id"
%token     <strval>    T_DIGIT  "digit"
%token     <strval>    T_NUM    "num"
%token     <strval>    T_SCONST "string"
%token     <strval>    T_CHARACTER "character" 
%token     <strval>    T_STRING "strings"
// lexikoi telestes
%token   <strval>   T_LPAREN             "("
%token   <strval>   T_RPAREN             ")"
%token    <strval>  T_SEMI               ";"
%token   <strval>   T_COMMA              ","
%token    <strval>  T_ASSIGN             "="
%token    <strval>  T_LBRACK             "["
%token    <strval>  T_RBRACK             "]"
%token   <strval>   T_LBRACE             "{"
%token   <strval>   T_RBRACE             "}"
%token   <strval>   T_DDOT               ":"

%token T_EOF       0                    "EOF"

%type <strval>  program program_body stmt assign_stmt
%type <strval>  while_stmt for_stmt if_stmt if_tail
%type <strval>  switch_stmt switch_tail break_stmt print_stmt
%type <strval>  function_declaration function_body variable_declaration
%type <strval>  identifier_list parameter_list expression number data_type


%left T_COMMA
%right T_ASSIGN
%left  T_OROP
%left T_ANDOP
%left T_EQUOP
%left T_RELOP
%left T_ADDOP
%left T_MULOP
%left T_LPAREN T_RPAREN T_LBRACK T_RBRACK T_LBRACE T_RBRACE


%nonassoc LOWER_THAN_ELSE
%nonassoc T_ELSEIF
%nonassoc T_ELSE

%start program

/* 75 , 76 , 125 \n */

%%


program:                 T_PROGRAM T_ID  function_declaration program_body
                        |T_PROGRAM T_ID  program_body
                        ;

program_body:            T_STARTMAIN variable_declaration stmt T_ENDMAIN
                        |T_STARTMAIN stmt T_ENDMAIN
                        |T_STARTMAIN T_ENDMAIN
                        ;

stmt:                    assign_stmt
                        |while_stmt
                        |for_stmt
                        |if_stmt
                        |switch_stmt
                        |break_stmt
                        |print_stmt
                        ;

assign_stmt:             T_ID T_ASSIGN T_NUM
                        |T_ID T_ASSIGN T_ID
                        |T_ID T_ASSIGN expression
                        ;

while_stmt:              T_WHILE expression T_ENDWHILE
                        ;

for_stmt:                T_FOR T_ID T_DDOT T_ASSIGN T_NUM T_TO T_NUM T_STEP T_NUM expression T_ENDFOR
                        ;

if_stmt:                 T_IF T_LPAREN expression T_RPAREN T_THEN stmt if_tail
                        ;

if_tail:                 T_ELSEIF stmt
                        |T_ELSE stmt
                        |%empty {} %prec LOWER_THAN_ELSE
                        ;                        

switch_stmt:             T_SWITCH T_LPAREN expression T_RPAREN switch_tail
                        ;

switch_tail:             T_CASE T_LPAREN expression T_RPAREN stmt
                        |%empty  {}   
                        ;

break_stmt:              T_BREAK T_SEMI
                        ;

print_stmt:              T_LPAREN T_STRING T_COMMA T_ID T_RPAREN T_SEMI
                        |T_LPAREN T_STRING T_RPAREN T_SEMI
                        ;

function_declaration:    T_FUNCTION T_ID T_LPAREN parameter_list T_RPAREN  function_body T_RETURN T_DIGIT T_END_FUNCTION
                        ;
function_body:           variable_declaration
                        |%empty {}
                        ;

variable_declaration:    T_VARS data_type identifier_list T_SEMI
                        ;

identifier_list:         T_ID 
                        |identifier_list T_COMMA T_ID
                        ;

parameter_list:          number
                        |parameter_list T_COMMA number
                        |number T_ASSIGN number
                        ;

expression:              data_type T_ID
                        |expression T_ASSIGN number
                        |expression T_COMMA T_ID
                        |expression T_ASSIGN T_LBRACE parameter_list T_RBRACE
                        |expression T_OROP expression
                        |expression T_ANDOP expression
                        |expression T_EQUOP expression
                        |expression T_RELOP expression
                        |expression T_ADDOP expression
                        |expression T_MULOP expression
                        ;

number:                  T_DIGIT
                        |T_CHARACTER
                        ;

data_type:		        T_INTEGER
				        |T_ID
				        ;



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

void yyerror(const char* err){
    error_counter++;
    printf("[ERROR-LINE %d] %s\n" , yylineno, err);

    if(error_counter==8){
        printf("MAXIMUM ERRORS FOUND\n");
        exit(EXIT_FAILURE);
    }

  //  yyless(1);
}