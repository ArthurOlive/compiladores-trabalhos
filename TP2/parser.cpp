#include "parser.h"
#include "tokens.h"
#include <iostream>
#include <string>
#include <fstream>
using namespace std;

void Parser::Start() {
    // enquanto não atingir o fim da entrada
 
    Block();

    cout << "\n";
    cout << "Tags HTML: " << tags << "\n";
    cout << "Linhas: " << lin - 1 << "\n";
    cout << "Caracteres : " << characteres << "\n";
}

void Parser::Block() {

    while ((lookahead = scanner.yylex()) != 0) {
        // trata o token recebido do analisador léxico
        switch(lookahead)
        {
            case OPENTAG: 
                for (int i = 0; i < block; i++) {
                    cout << "|\t";
                }
                
                tags ++;
                cout << "+--" << scanner.YYText() << "\n"; 

                block++;
                break;

            case JUMP:
                lin++;
                break;

            case OPENSTYLE:

                while ((lookahead = scanner.yylex()) != 0){
                    if (lookahead == CLOSESTYLE) {
                        break;
                    }
                    else if (lookahead == JUMP) {
                        lin++;
                    }
                } 

                break;

            case INLINE:
                tags ++;

                for (int i = 0; i < block; i++) {
                    cout << "|\t";
                }
                
                cout << "+--" << scanner.YYText() << "\n"; 

                break;
                
            case CLOSETAG: 

                block--;
                for (int i = 0; i < block; i++) {
                    cout << "|\t";
                }
                cout << "+--" << scanner.YYText() << "\n"; 
                break;

            case COMMENT: 
                texto++; 
                break;

            case TEXT: 
                characteres += scanner.YYLeng();

                for (int i = 0; i < block; i++) {
                    cout << "|\t";
                }

                cout << "+--" << "Texto[" <<  scanner.YYLeng() << "]" << "\n"; 
                texto++; 
                break;
        }
    }
    
}
