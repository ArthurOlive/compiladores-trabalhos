%{
#include <iostream>
#include "tokens.h"
using namespace std;
%}

%option noyywrap

delim	[ \t]*
brancos {delim}*
jump    [\n]
barra           [//]{1}
text            [A-Za-z1-6]
attr            [ ][a-z]+=\".*\"
tag             (?:html|head|style|title|body|h[1-6]|p|b|i|table|tr|td|th|ul|li|a)
tagin           (?:img|br)
opentag         <{tag}{attr}*>
closetag        <{barra}{text}+>
contenttext     [a-zA-Z 0-9,.:\-;%\"+&)(]*
comment         <!--{contenttext}*-->
openstyletag    [.# ]*[A-Za-z0-9\-]*[ ]*\{
closestyletag   \}
doc             <![A-Z]*[ a-z]*>
inlinetag       <{tagin}{attr}*>

%%

{brancos}	    ; // nenhuma ação e nenhum retorno
{jump}          return JUMP;
{opentag}       return OPENTAG;
{closetag}      return CLOSETAG;
{comment}       return COMMENT;
{contenttext}   return TEXT;
{inlinetag}     return INLINE;
{openstyletag}  return OPENSTYLE;
{closestyletag} return CLOSESTYLE;
{doc}           return COMMENT;

%%