/* A Bison parser, made by GNU Bison 3.8.2.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2021 Free Software Foundation,
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
   along with this program.  If not, see <https://www.gnu.org/licenses/>.  */

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

/* DO NOT RELY ON FEATURES THAT ARE NOT DOCUMENTED in the manual,
   especially those whose name start with YY_ or yy_.  They are
   private implementation details that can be changed or removed.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token kinds.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    YYEMPTY = -2,
    YYEOF = 0,                     /* "end of file"  */
    YYerror = 256,                 /* error  */
    YYUNDEF = 257,                 /* "invalid token"  */
    HEADER = 258,                  /* HEADER  */
    KEYWORD = 259,                 /* KEYWORD  */
    ESC_SEQ = 260,                 /* ESC_SEQ  */
    INTEGER = 261,                 /* INTEGER  */
    IDENTIFIER = 262,              /* IDENTIFIER  */
    INT = 263,                     /* INT  */
    FLOAT = 264,                   /* FLOAT  */
    CHAR = 265,                    /* CHAR  */
    DOUBLE = 266,                  /* DOUBLE  */
    FOR = 267,                     /* FOR  */
    SWITCH = 268,                  /* SWITCH  */
    CASE = 269,                    /* CASE  */
    BREAK = 270,                   /* BREAK  */
    COLON = 271,                   /* COLON  */
    DEFAULT = 272,                 /* DEFAULT  */
    OPEN_BRACKET = 273,            /* OPEN_BRACKET  */
    CLOSE_BRACKET = 274,           /* CLOSE_BRACKET  */
    OPEN_FBRACKET = 275,           /* OPEN_FBRACKET  */
    CLOSE_FBRACKET = 276,          /* CLOSE_FBRACKET  */
    OPEN_SBRACKET = 277,           /* OPEN_SBRACKET  */
    CLOSE_SBRACKET = 278,          /* CLOSE_SBRACKET  */
    REL_OP = 279,                  /* REL_OP  */
    LOG_OP = 280,                  /* LOG_OP  */
    ARITH_OP = 281,                /* ARITH_OP  */
    ASSIGN_OP = 282,               /* ASSIGN_OP  */
    UNARY_OP = 283,                /* UNARY_OP  */
    BIT_OP = 284,                  /* BIT_OP  */
    END = 285,                     /* END  */
    COMMA = 286,                   /* COMMA  */
    DOUBLE_QUOTE = 287,            /* DOUBLE_QUOTE  */
    SINGLE_QUOTE = 288,            /* SINGLE_QUOTE  */
    UNIDENTIFIED_TOKEN = 289,      /* UNIDENTIFIED_TOKEN  */
    CHARACTER = 290,               /* CHARACTER  */
    MAIN = 291,                    /* MAIN  */
    IF = 292,                      /* IF  */
    ELSE = 293,                    /* ELSE  */
    WHILE = 294,                   /* WHILE  */
    RETURN = 295                   /* RETURN  */
  };
  typedef enum yytokentype yytoken_kind_t;
#endif
/* Token kinds.  */
#define YYEMPTY -2
#define YYEOF 0
#define YYerror 256
#define YYUNDEF 257
#define HEADER 258
#define KEYWORD 259
#define ESC_SEQ 260
#define INTEGER 261
#define IDENTIFIER 262
#define INT 263
#define FLOAT 264
#define CHAR 265
#define DOUBLE 266
#define FOR 267
#define SWITCH 268
#define CASE 269
#define BREAK 270
#define COLON 271
#define DEFAULT 272
#define OPEN_BRACKET 273
#define CLOSE_BRACKET 274
#define OPEN_FBRACKET 275
#define CLOSE_FBRACKET 276
#define OPEN_SBRACKET 277
#define CLOSE_SBRACKET 278
#define REL_OP 279
#define LOG_OP 280
#define ARITH_OP 281
#define ASSIGN_OP 282
#define UNARY_OP 283
#define BIT_OP 284
#define END 285
#define COMMA 286
#define DOUBLE_QUOTE 287
#define SINGLE_QUOTE 288
#define UNIDENTIFIED_TOKEN 289
#define CHARACTER 290
#define MAIN 291
#define IF 292
#define ELSE 293
#define WHILE 294
#define RETURN 295

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;


int yyparse (void);


#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
