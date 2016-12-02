
%x SECTION_1
%x CAPTATITULO_SECTION
%x CAPTATITULO_SUBSECTION
%x CAPTATEXTO
%x CAPTACODIGO
%{
#include <stdio.h>
#include <stdlib.h>
int nc, np, nl;
char*code;
FILE* fp;

void EscribeSection(char* cadena);

void EscribeSubsection(char* cadena);

void EscribeTexto(char* cadena, int tamanio);

void EscribeMinted(char* cadena, int tam);

void Cabecera();
void Final();
%}
%%
"#Section:"						{BEGIN CAPTATITULO_SECTION;}
<SECTION_1>"#Section:"			{BEGIN CAPTATITULO_SECTION;}
<SECTION_1>"#Subsection:"		{BEGIN CAPTATITULO_SUBSECTION;}
<SECTION_1>"#Text:"				{BEGIN CAPTATEXTO;}
<SECTION_1>"#Code:"				{BEGIN CAPTACODIGO;}

<CAPTATITULO_SECTION>.+			{EscribeSection(yytext); BEGIN SECTION_1;}
<CAPTATITULO_SUBSECTION>.+		{EscribeSubsection(yytext);BEGIN SECTION_1;}
<CAPTATEXTO>([^@])*@			{EscribeTexto(yytext, yyleng);BEGIN SECTION_1;}
<CAPTACODIGO>([^@])*@			{EscribeMinted(yytext, yyleng);BEGIN SECTION_1;}

%%

int main(int argc, char*argv[]){
  if(argc == 4){
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
    code = argv[3];
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
  FILE* fin = fopen("Latex/section.txt","rt");
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
  FILE* fon = fopen("Latex/endsection.txt","rt");
  char t;
  t = fgetc(fon);
  fputc(t, fp);

  fclose ( fon);
}

void EscribeSubsection(char* cadena){
  FILE* fin = fopen("Latex/subsection.txt","rt");
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
  FILE* fon = fopen("Latex/endsection.txt","rt");
  char t;
  t = fgetc(fon);
  fputc(t, fp);
  t = fgetc(fon);
  fputc(t, fp);
  fclose ( fon);
}

void EscribeMinted(char*cadena, int tam){
  FILE* fin = fopen("Latex/beginminted.txt","rt");
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
  fputs(code, fp);

  FILE* fen = fopen("Latex/endsection.txt","rt");
  char t;
  t = fgetc(fen);
  fputc(t, fp);
  t = fgetc(fen);
  fputc(t, fp);
  fclose ( fen);
  int condition1;
  int condition2;
  int condition3;
  for(int i = 0; i < tam-1;i++){
  	condition1 = cadena[i] != '/' || cadena[i+1] != '/';
  	condition2 = cadena[i] != '*' || cadena[i+1] != '/';
  	condition3 = cadena[i] != '/' || cadena[i+1] != '*';
  	if((condition1 && condition2) && condition3){
  		fputc(cadena[i], fp);
    	printf("\nEnviado el caracter %c\n",cadena[i]);	
  	}
  	else{
  		i++;
  	}
    
  }
  fclose ( fin);
  FILE* fon = fopen("Latex/endminted.txt","rt");
  tx = fgetc(fon);
  while (tx != EOF)
 	{
    otro = tx;
 		fputc( otro, fp );
    tx = fgetc(fon);
 	}
  fclose ( fon);
}
void EscribeTexto(char* cadena,int tamanio){
  for(int i = 0; i < tamanio-1;i++){
    if((cadena[i] != '/' || cadena[i+1] != '/')){
        fputc(cadena[i], fp);
		}
		else{
			i++;
		}
  }
}
void Cabecera(){
  FILE* fin = fopen("Latex/Cabecera.txt","rt");
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
  FILE* fin = fopen("Latex/Final.txt","rt");
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
