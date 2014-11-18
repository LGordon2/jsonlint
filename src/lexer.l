space [ \t\r\v\f]*
integer "-"?([0-9]|[1-9][0-9]+)
exp	[eE][-+]?[0-9]+
frac	"."[0-9]+
%{
  #include "parser.h"
  #include <string.h>
%}

%%
\r?\n	{yylineno++;}
{space}	/* skip whitespace */
{integer}{frac}?{exp}? 	return NUMBER;
\"(?:'\\'[\\"bfnrt/]|'\\u'[a-fA-F0-9]{4}|[^\\\0-\x09\x0a-\x1f"])*\"  {strncpy(yytext,yytext+1,yyleng-2); yytext[yyleng-2]='\0'; return STRING;}
"null"		return NULL_LITERAL;
"true"		return TRUE;
"false"		return FALSE;
"{"		return '{';
"}"		return '}';
"["		return '[';
"]"		return ']';
","		return ',';
":"		return ':';
.		return INVALID;
%%
#ifndef yywrap
int yywrap() {return 1;}
#endif
