#include <FlexLexer.h>

class Parser
{
private:
	yyFlexLexer scanner;
	int lookahead;
    int texto = 1;
    int block = 0;
    int lin = 1;
    int tags = 0;
    int characteres = 0;

public:
	void Start();
    void Block();
};
