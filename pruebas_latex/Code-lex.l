
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

void EscribeMinted(char* cadena);

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
<CAPTATEXTO>(.|\n)*"#EndText"		{EscribeTexto(yytext);BEGIN SECTION_1;}
<CAPTACODIGO>(.|\n)*"#EndCode"		{EscribeMinted(yytext);BEGIN SECTION_1;}

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
  Final();
  return 0;
}

void EscribeSection(char* cadena){
  // fputs("\section{", fp);
  FILE* fin = fopen("section.txt","rt");
  char* texto;
  char tx;
  char otro;
  tx = fgetc(fin);
  while (tx != EOF)
 	{
    otro = tx;
 		fputc( otro, fp );
    tx = fgetc(fin);
 	}
  fputs(cadena, fp);
  fclose ( fin);
  FILE* fon = fopen("endsection.txt","rt");
  char t;
  t = fgetc(fon);
  fputc(t, fp);

  fclose ( fon);
}

void EscribeSubsection(char* cadena){
  FILE* fin = fopen("subsection.txt","rt");
  char* texto;
  char tx;
  char otro;
  tx = fgetc(fin);
  while (tx != EOF)
 	{
    otro = tx;
 		fputc( otro, fp );
    tx = fgetc(fin);
 	}
  fputs(cadena, fp);
  fclose ( fin);
  FILE* fon = fopen("endsection.txt","rt");
  char t;
  t = fgetc(fon);
  fputc(t, fp);
  t = fgetc(fon);
  fputc(t, fp);
  fclose ( fon);
}

void EscribeMinted(char*cadena){
  FILE* fin = fopen("beginminted.txt","rt");
  char* texto;
  char tx;
  char otro;
  tx = fgetc(fin);
  while (tx != EOF)
 	{
    otro = tx;
 		fputc( otro, fp );
    tx = fgetc(fin);
 	}
  fputs(cadena, fp);
  fclose ( fin);
  FILE* fon = fopen("endminted.txt","rt");
  tx = fgetc(fon);
  while (tx != EOF)
 	{
    otro = tx;
 		fputc( otro, fp );
    tx = fgetc(fon);
 	}
  fclose ( fon);
}
void EscribeTexto(char* cadena){
	//printf("Recibidooo desde texto %s\nFin de la norma",cadena );
	int i = 0;
	while (cadena[i] != '\0'){
    if((cadena[i] != '/' || cadena[i+1] != '/')){
      if(cadena[i] != '#'){
        fputc(cadena[i], fp);
        i++;
      }
      else{
        i++;
      }

		}
		else{
			i= i+2;
		}
	}
}
void Cabecera(){
  FILE* fin = fopen("Cabecera.txt","rt");
	if(fin == NULL){
    printf("El fichero no se puede abrir\n");
    exit(-1);
	}
	char texto;
  char otro;
  texto = fgetc(fin);
  while (texto != EOF)
 	{
    otro = texto;
 		fputc( otro, fp );
    texto = fgetc(fin);
 	}
	// fin.clear();
  fclose ( fin);
}

void Final(){
  FILE* fin = fopen("Final.txt","rt");
	if(fin == NULL){
    printf("El fichero no se puede abrir\n");
    exit(-1);
	}
	char texto;
  char otro;
  texto = fgetc(fin);
  while (texto != EOF)
 	{
    otro = texto;
 		fputc( otro, fp );
    texto = fgetc(fin);
 	}
	// fin.clear();
  fclose ( fin);
}
