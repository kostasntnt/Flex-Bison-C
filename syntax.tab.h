/* A Bison parser, made by GNU Bison 3.5.1.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2020 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* Undocumented macros, especially those whose name start with YY_,
   are private implementation details.  Do not rely on them.  */

#ifndef YY_YY_SYNTAX_TAB_H_INCLUDED
# define YY_YY_SYNTAX_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    T_EOF = 0,
    T_PROGRAM = 258,
    T_FUNCTION = 259,
    T_VARS = 260,
    T_CHAR = 261,
    T_INTEGER = 262,
    T_END_FUNCTION = 263,
    T_RETURN = 264,
    T_STARTMAIN = 265,
    T_ENDMAIN = 266,
    T_WHILE = 267,
    T_ENDWHILE = 268,
    T_FOR = 269,
    T_TO = 270,
    T_STEP = 271,
    T_ENDFOR = 272,
    T_IF = 273,
    T_THEN = 274,
    T_ELSEIF = 275,
    T_ELSE = 276,
    T_ENDIF = 277,
    T_SWITCH = 278,
    T_CASE = 279,
    T_DEFAULT = 280,
    T_ENDSWITCH = 281,
    T_BREAK = 282,
    T_OROP = 283,
    T_ANDOP = 284,
    T_EQUOP = 285,
    T_RELOP = 286,
    T_ADDOP = 287,
    T_MULOP = 288,
    T_ID = 289,
    T_DIGIT = 290,
    T_NUM = 291,
    T_SCONST = 292,
    T_CHARACTER = 293,
    T_STRING = 294,
    T_LPAREN = 295,
    T_RPAREN = 296,
    T_SEMI = 297,
    T_COMMA = 298,
    T_ASSIGN = 299,
    T_LBRACK = 300,
    T_RBRACK = 301,
    T_LBRACE = 302,
    T_RBRACE = 303,
    T_DDOT = 304,
    LOWER_THAN_ELSE = 305
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 18 "syntax.y"

int intval;
char *strval;

#line 114 "syntax.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_SYNTAX_TAB_H_INCLUDED  */
