%token NUMBER
%token NULL_LITERAL
%token STRING
%token TRUE 
%token FALSE
%token INVALID

%start JSONValue

%{
  #include <stdio.h>
  int yylineno;
  void yyerror(char *);
  extern char * yytext;
  extern char * fileName;
%}
%%
JSONBooleanLiteral : TRUE | FALSE;
JSONNullLiteral : NULL_LITERAL;
JSONNumber : NUMBER;
JSONString : STRING;
JSONArray : '[' ']'
	| '[' JSONElementList ']';
JSONMember : JSONString ':' JSONValue;
JSONMemberList : JSONMember
	| JSONMemberList ',' JSONMember;
JSONObject : '{' '}' 
	| '{' JSONMemberList '}';
JSONValue : JSONNullLiteral
	| JSONBooleanLiteral
	| JSONString
	| JSONNumber
	| JSONObject
	| JSONArray;
JSONElementList : JSONValue
	| JSONElementList ',' JSONValue;
%%
void yyerror(char *s){
  fprintf(stderr, "%s: %s near line %d\n", fileName, s, yylineno);
}
