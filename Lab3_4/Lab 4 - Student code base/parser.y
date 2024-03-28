%{

	#include "sym_tab.c"
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>
	#define YYSTYPE char*
	
	int type=-1;
	char *vval="~";
	int vtype=-1;
	int scope=0;

	void yyerror(char* s); // error handling function
	int yylex(); // declare the function performing lexical analysis
	extern int yylineno; // track the line number

%}

%token T_INT T_CHAR T_DOUBLE T_WHILE  T_INC T_DEC   T_OROR T_ANDAND T_EQCOMP T_NOTEQUAL T_GREATEREQ T_LESSEREQ T_LEFTSHIFT T_RIGHTSHIFT T_PRINTLN T_STRING  T_FLOAT T_BOOLEAN T_IF T_ELSE T_STRLITERAL T_DO T_INCLUDE T_HEADER T_MAIN T_ID T_NUM

%start START


%%
START : PROG { printf("Valid syntax\n"); YYACCEPT; }	
        ;	
	  
PROG :  MAIN PROG				
	|DECLR ';' PROG 				
	| ASSGN ';' PROG 			
	| 					
	;
	 

DECLR : TYPE LISTVAR 
	;	


LISTVAR : LISTVAR ',' VAR 
	  | VAR
	  ;

VAR: T_ID '=' EXPR 	{
				if(check_symbol_table($1))
				{
					printf("Variable %s already declared\n",$1);
					yyerror($1);
				} else{
					insert_into_table($1,strlen($1),type,yylineno,scope);
					insert_value_to_name($1,vval,yylineno);
					vval="~";
					type=-1;
				}
			}
     | T_ID 	{
				if(check_symbol_table($1))
				{
					printf("Variable %s already declared\n",$1);
					yyerror($1);
				} else {
					insert_into_table($1,strlen($1),type,yylineno,scope);
					insert_value_to_name($1,vval,yylineno);
					type=-1;
				}
			}	 

//assign type here to be returned to the declaration grammar
TYPE : T_INT {type=INT;}
       | T_FLOAT {type=FLOAT;}
       | T_DOUBLE {type=DOUBLE;}
       | T_CHAR {type=CHAR;}
       ;
    
/* Grammar for assignment */   
ASSGN : T_ID {type=retrieve_type($1);} '=' EXPR {
            if (!check_symbol_table($1)) {
                printf("Variable %s not declared\n", $1);
                yyerror($1);
            } else {
                insert_value_to_name($1, vval, yylineno);
            }
        }
    ;

EXPR : EXPR REL_OP E
       | E {vval=$1;}
       ;
	   
E : E '+' T {
			if(vtype==2)
				sprintf($$,"%d",(atoi($1)+atoi($3)));
			else if (vtype>=3)
				sprintf($$,"%1f",(atof($1)+atof($3)));
			else
			{
				printf("Character used in arithmetic\n");
				yyerror($$);
				$$="~";
			}
		}
    | E '-' T{
			if(vtype==2)
				sprintf($$,"%d",(atoi($1)-atoi($3)));
			else if (vtype>=3)
				sprintf($$,"%1f",(atof($1)-atof($3)));
			else
			{
				printf("Character used in arithmetic\n");
				yyerror($$);
				$$="~";
			}
		}
    | T {$$=$1;}
    ;
	
	
T : T '*' F {
			if(vtype==2)
				sprintf($$,"%d",(atoi($1)*atoi($3)));
			else if (vtype>=3)
				sprintf($$,"%1f",(atof($1)*atof($3)));
			else
			{
				printf("Character used in arithmetic\n");
				yyerror($$);
				$$="~";
			}
		}
    | T '/' F {
			if(vtype==2)
				sprintf($$,"%d",(atoi($1)/atoi($3)));
			else if (vtype>=3)
				sprintf($$,"%1f",(atof($1)/atof($3)));
			else
			{
				printf("Character used in arithmetic\n");
				yyerror($$);
				$$="~";
			}
		}
    | F {$$=$1;}
    ;

F : '(' EXPR ')'
    | T_ID {
		if(check_symbol_table($1))
		{
			char* check=retrieve_val($1);
			if(check=="~")
			{
				printf("Variable is not initialised",$1);
				yyerror($$);
			}
			else{
				$$=strdup(check);
				vtype=type_check(check);
				if(vtype!=type && !(vtype==3 && type==4) && type!=-1)
				{
					printf("Mismatch type\n");
					yyerror($1);
				}
			}
		}
	}
    | T_NUM {
		$$=strdup($1);
		vtype=type_check($1);
		if(vtype!=type && !(vtype==3 && type==4) && type!=-1)
		{
			printf("Mismatch type\n");
			yyerror($1);
		}
	}
    | T_STRLITERAL {
		$$=strdup($1);
		vtype=1;
		if(vtype!=type){
			printf("Mismatch type\n");
			yyerror($1);
		}
	}
    ;

IF_STMT : T_IF '(' COND ')' STMT
        | T_IF '(' COND ')' STMT T_ELSE STMT
        ;

STMT : STMT_NO_BLOCK STMT
       | BLOCK STMT
       | IF_STMT STMT
       ;

	

REL_OP :   T_LESSEREQ
	   | T_GREATEREQ
	   | '<' 
	   | '>' 
	   | T_EQCOMP
	   | T_NOTEQUAL
	   ;	


/* Grammar for main function */
MAIN : TYPE T_MAIN '(' EMPTY_LISTVAR ')' '{' {scope++;}STMT '}'{scope--;};

EMPTY_LISTVAR : LISTVAR
		|	
		;

STMT : STMT_NO_BLOCK STMT
       | BLOCK STMT
       |
       ;


STMT_NO_BLOCK : DECLR ';'
       | ASSGN ';' 
       ;

BLOCK : '{' {scope++;}STMT '}' {scope--;};

WHILE_2: '{' {scope++;}STMT '}' {scope--;}
		| ';'

COND : EXPR 
       | ASSGN
       ;


%%


/* error handling function */
void yyerror(char* s)
{
	printf("Error :%s at %d \n",s,yylineno);
}

int yywrap(){
	return(1);
}

int main(int argc, char* argv[])
{
	t = init_table();
	yyparse();
	display_symbol_table();
	return 0;

}
