%{
#include <iostream>
#include <cctype>
#include <unordered_map>
#include <string>
#include <sstream>
#include <cstring>
#include <math.h>

using namespace std;

int yylex(void);
int yyparse(void);
void yyerror(const char *);

char* substr(char* arr, int begin, int len);
string toString(float f);

unordered_map<string, double> variables;
string buffer = ""; /*vai armazenar a entrada do print*/

%}

%union {
    double num;
    char id[256];
    char text[5000];
}

%type <num> expr

%token <id> ID
%token <text> STRW
%token <num> NUM
%token EQ DIF LM RM
%token IF
%token PRINT
%token SQRT POW

%left '+' '-'
%left SQRT POW '*' '/' 
%left '<' '>' EQ DIF LM RM
%nonassoc IF
%nonassoc UMINUS

%%

/*Gramatica*/

main : main attr
    |  attr
    ;
    
attr: ID '=' expr                       { variables[$1] = $3;                               }
    | IF '(' expr ')' ID '=' expr       { if ($3 == 1 ) variables[$5] = $7;                 } 
    | IF '(' expr ')' PRINT'(' args ')' { if ($3 == 1 ) cout << buffer << "\n"; buffer = "";} 
    | PRINT '(' args ')'                { cout << buffer << "\n"; buffer = "";              }
    | expr
    | '\n'
    ;

args:  literal ',' args
    |  literal
    ;

literal: STRW               { buffer.append(substr($1, 1, strlen($1) - 2)); }
    | expr                  { buffer.append(toString($1));                  }
    ;    

expr: expr '+' expr                 { $$ = $1 + $3;         }
    | expr '-' expr                 { $$ = $1 - $3;         }
    | expr '*' expr                 { $$ = $1 * $3;         }
    | expr '/' expr 
    { 
        if ($3 == 0){
            yyerror("Divisão por zero");
        } else {
            $$ = $1 / $3; 
        }
    }
    | '(' expr ')'                  { $$ = $2;              }
    | '-' expr %prec UMINUS         { $$ = - $2;            }
    | expr '<' expr                 { $$ = $1 < $3;         }   
    | expr '>' expr                 { $$ = $1 > $3;         }     
    | expr EQ  expr                 { $$ = $1 == $3;        }
    | expr DIF expr                 { $$ = $1 != $3;        }
    | expr LM  expr                 { $$ = $1 <= $3;        }
    | expr RM  expr                 { $$ = $1 >= $3;        }
    | SQRT '(' expr ')'             { $$ = sqrt( $3 );      }
    | POW  '(' expr ',' expr ')'    { $$ = pow( $3, $5);    }
    | ID                            { $$ = variables[$1];   }
    | NUM                   
    ;

%%

extern FILE * yyin;

int main (int argc, char ** argv ) {

    if (argc > 1) {
        FILE * file;
        file = fopen(argv[1], "r");

        if (!file) {
            cout << "Arquivo " <<  argv[1] << " não pode ser aberto\n";
            exit(1);
        }
        yyin = file;
    }

    yyparse();
}

void yyerror (const char * s) {

    extern int yylineno;
    extern char * yytext;

    cout << "Erro sintático: \"" << s << "\" (linha " << yylineno << ")\n";
}

/*Metodo para retirar os " " da string do print*/
char* substr(char* arr, int begin, int len) {
    char* res = new char[len + 1];
    for (int i = 0; i < len; i++)
        res[i] = *(arr + begin + i);
    res[len] = 0;
    return res;
}

/*Metodo para transformar double em string*/
string toString(float f) {
    ostringstream bf;
    bf << f;
    return bf.str();
}
