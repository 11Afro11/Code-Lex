%{
#include<stdio.h>
int nc, np, nl;
void escribir_datos(int dato1, int dato2, int dato3);
%}
%%
[^\t\n]+  {np++;nc+=yyleng;}
[\t]+     {nc+=yyleng;}
\n        {nl++, nc++;}


%%

int main(int argc, char*argv[]){
  if(argc == 2){
    yyin = fopen(argv[1],"rt");
    if(yyin == NULL){
      printf("El fichero %s no se puede abrir\n", argv[1]);
      exit(-1);
    }
  }
  else yyin = stdin;
  nc = np = nl = 0;
  yylex();
  escribir_datos(nc, np, nl);
  return 0;
}

void escribir_datos(int dato1, int dato2, int dato3){
  printf("Num_caracteres=%d\tNum_palabras=%d\tNum_lineas=%d\n",dato1, dato2, dato3);
}
