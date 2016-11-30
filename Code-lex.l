%{
#include<stdio.h>
#include <stdlib.h>
int nc, np, nl;
FILE* fp;
void Detectar();
void EscribeSection(char* cadena);

void EscribeSubsection(char* cadena);

void EscribeMinted(char*cadena);

void Cabecera();

void Final();

%{

}

%}
%%
#Section:                        {BEGIN SECTION_1}

<SECTION_1>.+                    {EscribeSection(yytext)}
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

  Cabecera();
  yylex();
  return 0;
}

void escribir_datos(int dato1, int dato2, int dato3){
  printf("Num_caracteres=%d\tNum_palabras=%d\tNum_lineas=%d\n",dato1, dato2, dato3);
}

void EscribeSection(char* cadena){

}

void EscribeSubsection(char* cadena){

}

void EscribeMinted(char*cadena){

}

void Cabecera(){
  fin = fopen("./Latex/Cabecera.txt","rt");
	if(fin == NULL){
    printf("El fichero no se puede abrir\n");
    exit(-1);
	}
	string texto;
	while(getline(fin,texto)){
		fp << texto<<endl;
	}
	fin.clear();
}

void Final(){

}



void Detectar(){
  printf("Detectada cabecera\n")
}