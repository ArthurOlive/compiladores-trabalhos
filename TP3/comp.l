%{
#include "comp.tab.h"
%}

%option yylineno
%option noyywrap

digito      [0-9]
letra       [a-zA-Z_]

id          {letra}({letra}|{digito})*
numero		{digito}+("."{digito}+)?
strw        \"[a-zA-Z,0-9çÇÃÉ=\/\\ ]*\"

%%

[\t ]+		; // ignora espaço em branco
{numero}    { yylval.num = atof(yytext); return NUM; }
{id}        { 
                if (strcmp(yytext, "if") == 0) {
                    return IF;
                } else if (strcmp(yytext, "print") == 0) {
                    return PRINT;
                } else if (strcmp(yytext, "sqrt") == 0) {
                    return SQRT;
                } else if (strcmp(yytext, "pow") == 0) {
                    return POW;
                } else {
                    strcpy(yylval.id, yytext); 
                    return ID;
                }
            }
{strw}      { strcpy(yylval.text, yytext); return STRW; }
"=="        { return EQ; }
"<="        { return LM; }
">="        { return RM; }
"!="        { return DIF; }
.|\n		{ return yytext[0]; }

%%
