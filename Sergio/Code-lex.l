
%x SECTION_1
%x CAPTATITULO_SECTION
%x CAPTATITULO_SUBSECTION
%x CAPTATEXTO
%x CAPTACODIGO
%{
#include <stdio.h>
#include <stdlib.h>
int nc, np, nl;
FILE* fp;

void EscribeSection(char* cadena);

void EscribeSubsection(char* cadena);

void EscribeTexto(char* cadena);

void EscribeCodigo(char* cadena);

char* EliminaBarras(char* cadena, int size);

//void Cabecera();
%}
%%
.+"#Section:"						{BEGIN CAPTATITULO_SECTION;}
<SECTION_1>.*"#Section:"			{BEGIN CAPTATITULO_SECTION;}
<SECTION_1>.*"#Subsection:"			{BEGIN CAPTATITULO_SUBSECTION;}
<SECTION_1>.*"#Text:"				{BEGIN CAPTATEXTO;}
<SECTION_1>.*"#Code:"				{BEGIN CAPTACODIGO;}

<CAPTATITULO_SECTION>.+				{EscribeSection(yytext); BEGIN SECTION_1;}  
<CAPTATITULO_SUBSECTION>.+			{EscribeSubsection(yytext);BEGIN SECTION_1;}
<CAPTATEXTO>(.|\n)*"#EndText"		{char* tmp = EliminaBarras(yytext,yyleng);EscribeTexto(tmp);BEGIN SECTION_1;}
<CAPTACODIGO>(.|\n)*"#EndCode"		{EliminaBarras(yytext,yyleng);EscribeCodigo(yytext);BEGIN SECTION_1;}

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

  //Cabecera();
  yylex();
  return 0;
} 

void EscribeSection(char* cadena){
	printf("Recibidooo desde Section %s\nFin de la norma",cadena);
}

void EscribeSubsection(char* cadena){
	printf("Recibidooo desde Subsection %s\nFin de la norma",cadena);
}

void EscribeCodigo(char* cadena){
	printf("Recibidooo desde escribe codigo %s\nFin de la norma",cadena);
}
void EscribeTexto(char* cadena){
	//printf("Recibidooo desde texto %s\nFin de la norma",cadena );
	int i = 0;
	while (cadena[i] != '\0'){
		printf("%c\n",cadena[i]);
		i++;
	}
}
char* EliminaBarras(char* cadena, int size){
	char* tmp;
	tmp = (char*)malloc(size*sizeof(char));
	for(int i = 0; i < size; i++){
		if(cadena[i] != '/' || cadena[i+1] != '/'){
			tmp[i] = cadena[i];
			printf("aniadido el caracter%c\n",cadena[i]);
		}
		else{
			i++;
		}
	}
	return tmp;
}
/*
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
*/

