# Compiladores
CC=g++
LEX=flex++

# Dependências
all: tp2

tp2: main.o parser.o lex.yy.o
	$(CC) main.o parser.o lex.yy.o -o tp2

main.o: main.cpp parser.h
	$(CC) -c -std=c++17 main.cpp

parser.o: parser.cpp parser.h tokens.h
	$(CC) -c -std=c++17 parser.cpp

lex.yy.o: lex.yy.cc tokens.h
	$(CC) -c -std=c++17 lex.yy.cc

lex.yy.cc: lexer.l tokens.h
	$(LEX) lexer.l

clean:
	rm sample lex.yy.cc lex.yy.o parser.o sample.o main.o tp2
