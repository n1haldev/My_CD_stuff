%{
	#include "sym_tab.c"
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>
	#define YYSTYPE char*
	/*
		declare variables to help you keep track or store properties
		scope can be default value for this lab(implementation in the next lab)
	*/
	int scope = 0;
	int type = 0;
	int size = 0;
	symbol* res;
	symbol* e;
	symbol* t;
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
			/*
               			 Check if variable is declared in the table
               			 insert value
            		*/
				if(check_symbol_table($1) == 1)
					yyerror("Variable is redeclared!");
				else {
					insert_into_table($1, size, type, yylineno, scope);
					insert_value_to_name($1, $3);
				}
			}
     | T_ID 		{
				/*
                   			finished in lab 2
                    		*/
				if(check_symbol_table($1) == 1)
					yyerror("Variable is redeclared!");
				else {
					insert_into_table($1, size, type, yylineno, scope);
				}
			}	 

//assign type here to be returned to the declaration grammar
TYPE : T_INT { type = INT; size = 4; }
       | T_FLOAT { type = FLOAT; size = 4; }
       | T_DOUBLE { type = DOUBLE; size = 8; }
       | T_CHAR { type = CHAR; size = 1; }
       ;
    
/* Grammar for assignment */   
ASSGN : T_ID '=' EXPR 	{
			/*
               			 Check if variable is declared in the table
               			 insert value
            		*/
				if(check_symbol_table($1) == 1)
					insert_value_to_name($1, $3);
				else {
					insert_into_table($1, size, type, yylineno, scope);
					insert_value_to_name($1, $3);
				}
			}
	;

EXPR : EXPR REL_OP E
       | E 	//store value using value variable declared before
       ;
	   
/* Expression Grammar */	   
E : E '+' T 	{ 
		/*
		        check type
		        if character type return error
		        convert to int/float perform calculation
		        convert back to string 
		        copy to grammar rule E
          	*/
			res = get_symbol_by_name($$);
			e = get_symbol_by_name($1);
			t = get_symbol_by_name($3);
			char message[100];
			char result[30];

			if(e->type == t->type) {
				if(e->scope > 0) {
					if(t->scope > 0) {
						switch(e->type) {
							case INT: int t1_int = atoi(e->val);
							int t2_int = atoi(t->val);
                            int res_int;
							res_int = t1_int + t2_int;
							sprintf(result, "%d", res_int);
							free(res->val);
							res->val = result;
							break;

							case CHAR: snprintf(message, "%s + %s, Char additions are not allowed!", e->name, t->name);
							yyerror(message);
							break;

							case FLOAT: float t1_float = atof(e->val);
							float t2_float = atof(t->val);
                            float res_float;
							res_float = t1_float + t2_float;
							gcvt(res_float, 12, result);
							free(res->val);
							res->val = result;
							break;

							case DOUBLE: double t1, t2;
							sscanf(e->val, "%lf", &t1);
							sscanf(t->val, "%lf", &t2);
                            double res_db;
                            res_db = t1 + t2;
							sprintf(result, "%lf", res_db);
							free(res->val);
							res->val = result;
							break;
						}
					}
					else {
						snprintf(message, "variable %s is out of scope", t->name);
						yyerror(message);
					}
				}
				else {
					snprintf(message, "variable %s is out of scope", e->name);
					yyerror(message);
				}
			}
			else {
				snprintf(message, "Variables of %s and %s have to be of the same type for the operation", e->name, t->name);
				yyerror(message);
			}
		}
    | E '-' T 	{ 
		/*
			check type
			if character type return error
			convert to int/float perform calculation
			convert back to string 
			copy to grammar rule E
            	*/
			res = get_symbol_by_name($$);
			e = get_symbol_by_name($1);
			t = get_symbol_by_name($3);
			char message[100];
			char result[30];

			if(e->type == t->type) {
				if(e->scope > 0) {
					if(t->scope > 0) {
						switch(e->type) {
							case INT: int t1_int = atoi(e->val);
							int t2_int = atoi(t->val);
                            int res_int;
							res_int = t1_int - t2_int;
							sprintf(result, "%d", res_int);
							free(res->val);
							res->val = result;
							break;

							case CHAR: snprintf(message, "%s + %s, Char additions are not allowed!", e->name, t->name);
							yyerror(message);
							break;

							case FLOAT: float t1_float = atof(e->val);
							float t2_float = atof(t->val);
                            float res_float;
							res_float = t1_float - t2_float;
							gcvt(res_float, 12, result);
							free(res->val);
							res->val = result;
							break;

							case DOUBLE: double t1, t2;
							sscanf(e->val, "%lf", &t1);
							sscanf(t->val, "%lf", &t2);
                            double res_db;
                            res_db = t1 - t2;
							sprintf(result, "%lf", res_db);
							free(res->val);
							res->val = result;
							break;
						}
					}
					else {
						snprintf(message, "variable %s is out of scope", t->name);
						yyerror(message);
					}
				}
				else {
					snprintf(message, "variable %s is out of scope", e->name);
					yyerror(message);
				}
			}
			else {
				snprintf(message, "Variables of %s and %s have to be of the same type for the operation", e->name, t->name);
				yyerror(message);
			}
		}
    | T //copy value from T to grammar rule E
	{
		res = get_symbol_by_name($$);
		e = get_symbol_by_name($1);

		res->val = e->val;
	}
    ;
	
	
T : T '*' F 	{ 
		/*
		        check type
		        if character type return error
		        convert to int/float perform calculation
		        convert back to string 
		        copy to grammar rule T
            	*/
			res = get_symbol_by_name($$);
			e = get_symbol_by_name($1);
			t = get_symbol_by_name($3);
			char message[100];
			char result[30];

			if(e->type == t->type) {
				if(e->scope > 0) {
					if(t->scope > 0) {
						switch(e->type) {
							case INT: int t1_int = atoi(e->val);
							int t2_int = atoi(t->val);
                            int res_int;
							res_int = t1_int * t2_int;
							sprintf(result, "%d", res_int);
							free(res->val);
							res->val = result;
							break;

							case CHAR: snprintf(message, "%s + %s, Char additions are not allowed!", e->name, t->name);
							yyerror(message);
							break;

							case FLOAT: float t1_float = atof(e->val);
							float t2_float = atof(t->val);
                            float res_float;
							res_float = t1_float * t2_float;
							gcvt(res_float, 12, result);
							free(res->val);
							res->val = result;
							break;

							case DOUBLE: double t1, t2;
							sscanf(e->val, "%lf", &t1);
							sscanf(t->val, "%lf", &t2);
                            double res_db;
                            res_db = t1 * t2;
							sprintf(result, "%lf", res_db);
							free(res->val);
							res->val = result;
							break;
						}
					}
					else {
						snprintf(message, "variable %s is out of scope", t->name);
						yyerror(message);
					}
				}
				else {
					snprintf(message, "variable %s is out of scope", e->name);
					yyerror(message);
				}
			}
			else {
				snprintf(message, "Variables of %s and %s have to be of the same type for the operation", e->name, t->name);
				yyerror(message);
			}
		}
    | T '/' F 	{ 
		/*
		        check type
		        if character type return error
		        convert to int/float perform calculation
		        convert back to string 
		        copy to grammar rule T
           	*/
			res = get_symbol_by_name($$);
			e = get_symbol_by_name($1);
			t = get_symbol_by_name($3);
			char message[100];
			char result[30];

			if(e->type == t->type) {
				if(e->scope > 0) {
					if(t->scope > 0) {
						switch(e->type) {
							case INT: int t1_int = atoi(e->val);
							int t2_int = atoi(t->val);
                            int res_int;
							res_int = t1_int / t2_int;
							sprintf(result, "%d", res_int);
							free(res->val);
							res->val = result;
							break;

							case CHAR: snprintf(message, "%s + %s, Char additions are not allowed!", e->name, t->name);
							yyerror(message);
							break;

							case FLOAT: float t1_float = atof(e->val);
							float t2_float = atof(t->val);
                            float res_float;
							res_float = t1_float / t2_float;
							gcvt(res_float, 12, result);
							free(res->val);
							res->val = result;
							break;

							case DOUBLE: double t1, t2;
							sscanf(e->val, "%lf", &t1);
							sscanf(t->val, "%lf", &t2);
                            double res_db;
                            res_db = t1 / t2;
							sprintf(result, "%lf", res_db);
							free(res->val);
							res->val = result;
							break;
						}
					}
					else {
						snprintf(message, "variable %s is out of scope", t->name);
						yyerror(message);
					}
				}
				else {
					snprintf(message, "variable %s is out of scope", e->name);
					yyerror(message);
				}
			}
			else {
				snprintf(message, "Variables of %s and %s have to be of the same type for the operation", e->name, t->name);
				yyerror(message);
			}
		}
    | F //copy value from F to grammar rule T
	{
		res = get_symbol_by_name($$);
		e = get_symbol_by_name($1);

		res->val = e->val;
	}
    ;

F : '(' EXPR ')'
    | T_ID 	{
		/*
		        check if variable is in table
		        check the value in the variable is default
		        if yes return error for variable not initialised
		        else duplicate value from T_STRLITERAL to F
		        check for type match
		        (secondary type variable used here)
            	*/
		}
    | T_NUM 	{
    		/*
		        duplicate value from T_NUM to F
		        check for type match
		        (secondary type variable used here)
                */
		}
    | T_STRLITERAL {
            	/*
			duplicate value from T_STRLITERAL to F
			check for type match
			(secondary type variable used here)
            	*/
		}
    ;



REL_OP :   T_LESSEREQ
	   | T_GREATEREQ
	   | '<' 
	   | '>' 
	   | T_EQCOMP
	   | T_NOTEQUAL
	   ;	


/* Grammar for main function */
//increment and decrement at particular points in the grammar to implement scope tracking
MAIN : TYPE T_MAIN '(' EMPTY_LISTVAR ')' '{' {scope++;} STMT '}' {scope--;};

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
       
//increment and decrement at particular points in the grammar to implement scope tracking
BLOCK : '{' {scope++;} STMT '}' {scope--;};

COND : EXPR 
       | ASSGN
       ;


%%


/* error handling function */
void yyerror(char* s)
{
	printf("Error :%s at %d \n",s,yylineno);
}


int main(int argc, char* argv[])
{
	/* initialise table here */
	t = allocate_space_for_table();
	yyparse();
	display_symbol_table();
	/* display final symbol table*/
	return 0;

}
