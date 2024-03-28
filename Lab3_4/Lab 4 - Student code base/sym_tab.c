#include "sym_tab.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Function to initialize the symbol table
table* init_table()
{
    table* t = (table*)malloc(sizeof(table));
    if (t == NULL) {
        fprintf(stderr, "Memory allocation failed\n");
        exit(EXIT_FAILURE);
    }
    t->head = NULL;
    return t;
}

// Function to initialize a symbol entry
symbol* init_symbol(char* name, int size, int type, int lineno, int scope)
{
    symbol *s = (symbol *)malloc(sizeof(symbol));
    if (s == NULL) {
        fprintf(stderr, "Memory allocation failed\n");
        exit(EXIT_FAILURE);
    }
    s->name = (char *)malloc(sizeof(char) * (size + 1));
    if (s->name == NULL) {
        fprintf(stderr, "Memory allocation failed\n");
        exit(EXIT_FAILURE);
    }
    strcpy(s->name, name);
    s->size = size;
    s->type = type;
    s->line = lineno;
    s->val = (char*)malloc(sizeof(char) * 10);
    if (s->val == NULL) {
        fprintf(stderr, "Memory allocation failed\n");
        exit(EXIT_FAILURE);
    }
    strcpy(s->val, "~");
    s->next = NULL;
    s->scope = scope;
    return s;
}

// Function to insert a symbol into the symbol table
void insert_into_table(char* name, int size, int type, int lineno, int scope)
{
     switch(type) {
        case INT:
            size = 2;
            break;
        case CHAR:
            size = 1;
            break;
        case FLOAT:
            size = 4;
            break;
        case DOUBLE:
            size = 4;
            break;
        default:
            fprintf(stderr, "Invalid type\n");
            exit(EXIT_FAILURE);
    }
    symbol* s = init_symbol(name, size, type, lineno, scope);
    if (t->head == NULL) {
        t->head = s;
        return;
    }
    symbol* curr = t->head;
    while (curr->next != NULL) {
        curr = curr->next;
    }
    curr->next = s;
}

// Function to check if a symbol is present in the symbol table
int check_symbol_table(char * name)
{
    if (t->head == NULL) {
        return 0;
    }
    symbol* curr = t->head;
    while (curr != NULL) {
        if (strcmp(curr->name, name) == 0) {
            return 1;
        }
        curr = curr->next;
    }
    return 0;
}

// Function to insert a value into a symbol entry in the symbol table
void insert_value_to_name(char *name, char *value, int lineno)
{
    if (strcmp(value, "~") == 0) {
        return;
    }
    if (t->head == NULL) {
        return;
    }
    symbol* curr = t->head;
    while (curr != NULL) {
        if (strcmp(curr->name, name) == 0) {
            strcpy(curr->val, value);
            curr->line = lineno;
            return;
        }
        curr = curr->next;
    }
}

// Function to display the contents of the symbol table
void display_symbol_table()
{
    symbol* curr = t->head;
    if (curr == NULL) {
        return;
    }
    printf("Name\tSize\tType\tLineno\tScope\tValue\n");
    while (curr != NULL) {
        printf("%s\t%d\t%d\t%d\t%d\t%s\n", curr->name, curr->size, curr->type, curr->line, curr->scope, curr->val);
        curr = curr->next;
    }
}

// Function to retrieve the value associated with a symbol from the symbol table
char* retrieve_val(char * name)
{
    char *val = "~";
    if (t->head == NULL) {
        return val;
    }
    symbol * curr = t->head;
    while (curr != NULL) {
        if (strcmp(curr->name, name) == 0) {
            val = curr->val;
            return val;
        }
        curr = curr->next;
    }
    return val;
}

// Function to retrieve the type associated with a symbol from the symbol table
int retrieve_type(char *name)
{
    int type = -1;
    if (t->head == NULL) {
        return type;
    }
    symbol* curr = t->head;
    while (curr != NULL) {
        if (strcmp(curr->name, name) == 0) {
            type = curr->type;
            return type;
        }
        curr = curr->next;
    }
    return type;
}

// Function to check the type of a value
int type_check(char *value) {
    char *s = strchr(value, '\"');
    if (s != NULL) {
        return 1; // String type
    }
    char *f = strchr(value, '.');
    if (f != NULL) {
        return 3; // Floating-point type
    }
    return 2; // Integer type
}
