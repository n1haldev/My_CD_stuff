%option yylineno
%{
#include <stdio.h>
#include "y.tab.h"
#include <stdlib.h>
    

%}

%%
"#"[ ]*"include"[ ]*<.+\.h>      { return HEADER; }
return                            { return RETURN; }
while                             { return WHILE;}
main                              { return MAIN;}
if                                { return IF;}
else                              { return ELSE;}
int                               {  return INT; }
float                             {  return FLOAT; }
char                              {  return CHAR; }
double                            {  return DOUBLE; }
for                               { return FOR; }
switch                            { return SWITCH; }
case                              { return CASE; }
break                             { return BREAK; }
default                           { return DEFAULT; }
\\n|\\t|\\a                       { return ESC_SEQ; }
[0-9]+(\.[0-9]+)?                  { return INTEGER; }
\'[a-zA-z_]\'                       { return CHARACTER; }
[a-zA-z_][a-zA-z0-9]*             { return IDENTIFIER; }
\[                                { return OPEN_SBRACKET; }
\]                                { return CLOSE_SBRACKET; }
\(                                { return OPEN_BRACKET; }
\)                                { return CLOSE_BRACKET; }
\{                                { return OPEN_FBRACKET; }
\}                                { return CLOSE_FBRACKET; }
"/*"([^*]|\*+[^*/])*\*+"/"|\/\/(.*) ;
"<="|">="|"=="|"!="|">"|"<"       { return REL_OP; }
"&&"|"||"|"!"                     { return LOG_OP; }
"+"|"-"|"/"|"*"|"%"               { return ARITH_OP; }
\=|"+="|"-="|"*="|"/="           { return ASSIGN_OP; }
"++"|"--"                         { return UNARY_OP; }
"&"|"|"|"^"|"~"|"<<"|">>"         { return BIT_OP; }
;                                 { return END; }
:                                 { return COLON; }
,                                 { return COMMA; }
\"                                { return DOUBLE_QUOTE; }
\'                                { return SINGLE_QUOTE; }
[ ]*|\n|\t                        ;
[[:space:]]+                      ;
.                                 { return UNIDENTIFIED_TOKEN; }

%%

int yywrap(){
    return 1;
}