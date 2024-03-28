#!/bin/bash

lex lexer.l
yacc -d parser_lab3.y -Wno
gcc -g y.tab.c lex.yy.c

./a.out<sample_input1.c>output1.txt
