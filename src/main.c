#include <stdio.h>
#include <libgen.h>
#include <unistd.h>
#include "parser.h"
int yyparse();
extern FILE * yyin;
char * fileName;
int main(int argc, char *argv[]){
  extern int yylineno;
  int error, prog_error=0;
  int i;
  if(argc<2){
    fprintf(stderr,"usage: %s JSONFile ...\n",basename(argv[0]));
    return 1; 
  }

  for(i=1;i<argc;i++){
    yylineno=1;
    fileName = argv[i];
    yyin = fopen(fileName,"r");
    yyrestart(yyin);
    if(!yyin){
      fprintf(stderr,"Invalid JSON file!\n");
      return 1;
    }
    error = yyparse();
    prog_error |= error;
    if(!error)
      printf("%s: Valid JSON\n",argv[i]);
  }
  return prog_error;
}
