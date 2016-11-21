%{
#include<stdio.h>
#include <stdlib.h>
int nc, np, nl;
FILE* fp;

void encriptado(char* solucion);
%}
%%
[^\b\t\n]+  {encriptado(yytext);fputs(yytext, fp);}
[^\t\n]+  {fputs(yytext, fp);}
[\t]+     {fputs(yytext, fp);}
\n        {fputs(yytext, fp);}

%%

int main(int argc, char*argv[]){
  if(argc == 3){
    yyin = fopen(argv[1],"rt");
    if(yyin == NULL){
      printf("El fichero %s no se puede abrir\n", argv[1]);
      exit(-1);
    }
    fp = fopen(argv[2], "wt" );
    if(fp == NULL){
      printf("El fichero %s no se puede abrir\n", argv[2]);
      exit(-1);
    }
  }
  else yyin = stdin;
  nc = np = nl = 0;


  yylex();
  return 0;
}

void escribir_datos(int dato1, int dato2, int dato3){
  printf("Num_caracteres=%d\tNum_palabras=%d\tNum_lineas=%d\n",dato1, dato2, dato3);
}

void Detectar(){
  printf("Detectada cabecera\n")
}
