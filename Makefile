CC = gcc

FLEX = flex
YACC = yacc

CFLAGS = -Wall -std=c11

TARGET = regex_parser

LEX_SOURCE = lexer.l
YACC_SOURCE = parser.y

LEX_OUTPUT = lex.yy.c
YACC_OUTPUT = y.tab.c
YACC_HEADER = y.tab.h

all: $(TARGET)

$(TARGET): $(LEX_OUTPUT) $(YACC_OUTPUT)
	$(CC) $(CFLAGS) -o $(TARGET) $(LEX_OUTPUT) $(YACC_OUTPUT)

$(LEX_OUTPUT): $(LEX_SOURCE)
	$(FLEX) $(LEX_SOURCE)

$(YACC_OUTPUT): $(YACC_SOURCE)
	$(YACC) -d $(YACC_SOURCE)

clean:
	rm -f $(TARGET) $(LEX_OUTPUT) $(YACC_OUTPUT) $(YACC_HEADER)
