#!/bin/bash

lex lexer.l
yacc -d parser.y -Wno
gcc -g y.tab.c lex.yy.c

# ./a.out<my_sample.c>my_out.txt
./a.out<sample_input1.c>output1.txt
# ./a.out<sample_input2.c>output2.txt
# ./a.out<sample_input3.c>output3.txt
