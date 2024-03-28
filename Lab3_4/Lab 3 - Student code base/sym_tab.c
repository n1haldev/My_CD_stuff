#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "sym_tab.h"

table* init_table()	
{
	/*
        allocate space for table pointer structure eg (t_name)* t
        initialise head variable eg t->head
        return structure
    	*/
    table* t = (table*)malloc(sizeof(table));
    t->head = NULL;
    return t;
}

table* allocate_space_for_table() {
    table* new_table = init_table();
    return new_table;
}

symbol* init_symbol(char* name, int size, int type, int lineno, int scope) //allocates space for items in the list
{
	/*
        allocate space for entry pointer structure eg (s_name)* s
        initialise all struct variables(name, value, type, scope, length, line number)
        return structure
    	*/
    symbol* s = (symbol*)malloc(sizeof(symbol));
    // strcpy(s->name, name);
    s->name = name;
    s->size = size;
    s->type = type;
    s->line = lineno;
    s->scope = scope;
    s->next = NULL;
    s->val="~";

    return s;
}

symbol* allocate_space_for_table_entry(char* name, int size, int type, int lineno, int scope) {
    symbol* entry = init_symbol(name, size, type, lineno, scope);
    return entry;
}

void insert_into_table(char* name, int size, int type, int lineno, int scope)/* 
 arguments can be the structure s_name already allocated before this function call
 or the variables to be sent to allocate_space_for_table_entry for initialisation        
*/
{
    /*
        check if table is empty or not using the struct table pointer
        else traverse to the end of the table and insert the entry
    */
   symbol* sym = allocate_space_for_table_entry(name, size, type, lineno, scope);
   if(t->head == NULL) {
    t->head = sym;
   }
   else {
    symbol* cur = t->head;
    
    while(cur != NULL && cur->next != NULL) {
        cur = cur->next;
    }
    cur->next = sym;
   }
}

int check_symbol_table(char* name) //return a value like integer for checking
{
    /*
        check if table is empty and return a value like 0
        else traverse the table
        if entry is found return a value like 1
        if not return a value like 0
    */
   if(t->head == NULL) {
    return 0;
   }
   else {
    symbol* entry = t->head;
    while(entry != NULL) {
        if(strcmp(entry->name, name) == 0) {
            return 1;
        }
        entry = entry->next;
    }
   }
   return 0;
}

void insert_value_to_name(char* name, char* value)
{
    /*
        if value is default value return back
        check if table is empty
        else traverse the table and find the name
        insert value into the entry structure
    */
   symbol* cur = t->head;
    while(cur != NULL) {
        if(strcmp(cur->name, name) == 0 && cur->val != NULL) {
            cur->val = value;
        }
        cur = cur->next;
    }
}

void display_symbol_table()
{
    /*
        traverse through table and print every entry
        with its struct variables
    */
   symbol* cur = t->head;

   if(t->head==NULL){
        printf("table is empty \n");
        return;
    }
    printf("--------------symbol table--------------------\n");
    printf(" name\tsize\ttype\tlineno\tscope\tval \n");
    for(symbol*curr=t->head;curr!=NULL;curr=curr->next){
        printf(" %s\t\t%d\t\t%d\t\t%d\t\t%d\t\t%s \n",curr->name,curr->size,curr->type,curr->line,curr->scope,curr->val);
    }
    printf("----------------------------------------------\n");
}
