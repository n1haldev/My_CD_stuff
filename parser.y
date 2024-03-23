%{
#include<stdio.h>

extern int yylex();
extern int yylineno;
extern char* yytext;

int yyerror_count = 0; // Define yyerror_count to track the number of errors

void yyerror(char *s) {
    printf("Error: %s, line number: %d, token: %s\n", s, yylineno, yytext);
    yyerror_count++;
    // yyerror;  // Signal error state
}
%}

%token HEADER KEYWORD ESC_SEQ INTEGER IDENTIFIER 
%token INT FLOAT CHAR DOUBLE
%token FOR SWITCH CASE BREAK COLON DEFAULT
%token OPEN_BRACKET CLOSE_BRACKET OPEN_FBRACKET CLOSE_FBRACKET
%token REL_OP LOG_OP ARITH_OP ASSIGN_OP UNARY_OP BIT_OP
%token END COMMA DOUBLE_QUOTE SINGLE_QUOTE UNIDENTIFIED_TOKEN CHARACTER
%token MAIN IF ELSE WHILE RETURN 

%%

Start : Prog ;

Prog : HEADER Prog
    | MainF Prog
    | Decl END Prog
    | Assgn END Prog
    | ;

Decl : Type ListVar | Type Assgn ;

ListVar : ListVar COMMA IDENTIFIER | IDENTIFIER ;

Type : INT | FLOAT | DOUBLE | CHAR ;

Assgn : Assgn COMMA IDENTIFIER ASSIGN_OP Expr | IDENTIFIER ASSIGN_OP Expr | Assgn COMMA IDENTIFIER ;

Expr : Expr REL_OP E | E | Expr LOG_OP E ;

E : E ARITH_OP T | T ;

T : OPEN_BRACKET Expr CLOSE_BRACKET | IDENTIFIER | INTEGER | CHARACTER | Unary ;

Unary : UNARY_OP IDENTIFIER | IDENTIFIER UNARY_OP | ;

MainF : Type MAIN OPEN_BRACKET Empty_ListVar CLOSE_BRACKET OPEN_FBRACKET Stmt CLOSE_FBRACKET ;

Empty_ListVar : ListVar | ;

Stmt : SingleStmt Stmt | Block Stmt | ;

SingleStmt : Decl END | Assgn END | IF OPEN_BRACKET Cond CLOSE_BRACKET Stmt | IF OPEN_BRACKET Cond CLOSE_BRACKET Stmt ELSE mystmt | WhileL | ForL | Switch ;

mystmt : SingleStmt Stmt | Block Stmt ;

Block : OPEN_FBRACKET Stmt CLOSE_FBRACKET ;

WhileL : WHILE OPEN_BRACKET Cond CLOSE_BRACKET While_2 ;

ForL : FOR OPEN_BRACKET ForInit END ForCond END ForIter CLOSE_BRACKET For_2 ;

ForInit : ForInit COMMA Decl | ForInit COMMA Assgn | Decl | Assgn | ;

ForCond : Expr | ;

ForIter : Assgn COMMA ForIter | Assgn | Unary COMMA ForIter | Unary | ;

For_2 : OPEN_FBRACKET Stmt CLOSE_FBRACKET | SingleStmt | ;

Switch : SWITCH OPEN_BRACKET Expr CLOSE_BRACKET OPEN_FBRACKET CaseList Default CLOSE_FBRACKET ;

CaseList : Case CaseList | ;

Case : CASE Expr COLON Stmt breakL ;

Default : DEFAULT COLON Stmt breakL ;

breakL : BREAK END | ;

Cond : Expr | Assgn ;

While_2 : OPEN_FBRACKET Stmt CLOSE_FBRACKET | SingleStmt | ;

%%

int main() {
    yyparse();
    /* if (yyerror_count > 0) {
        printf("Syntax errors encountered.\n");
    } */
    printf("%d",yyerror_count);
    return 0;
}