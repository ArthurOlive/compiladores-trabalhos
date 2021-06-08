all: comp

# Compiladores
CPP=g++
FLEX=flex
BISON=bison

comp: lex.yy.c comp.tab.c
	$(CPP) lex.yy.c comp.tab.c -std=c++17 -o comp

lex.yy.c: comp.l
	$(FLEX) comp.l

comp.tab.c: comp.y
	$(BISON) -d comp.y

clean:
	rm comp lex.yy.c comp.tab.c comp.tab.h