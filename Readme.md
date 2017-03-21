#Code Lex
Hecho por:

[Francisco Javier Fuentes Barragán](https://github.com/11Afro11).

[Sergio Carrasco Márquez](https://github.com/scmarquez).


Traducctor de Comentarios de Código a Latex.

Para poder hacer uso de este programa es necesario tener instalada la librería minted de latex.

Para ejecutar la práctica debemos darle permiso de ejecución al archivo Compilacion.sh:

`chmod +x Compilacion.sh`

Despues debemos de pasarle 3 parámetros a ese fichero:

1. Fichero que queremos comentar
2. Fichero de salida con extensión.tex.
3. Lenguaje empleado en el primer fichero (Funciona bien en c, c++ y java)

`./Compilacion <nombre>.c++ <nombre>.tex c++`


## Método de empleo

//#Section: Esta es la seccion 1

//#Section: Esta es la seccion 2

//#Subsection: Esta el la subseccion 1

//#Text: Este es el

//primer texto

//con varias lineas

//@ Terminador del texto

//#Code:

Código que queremos que se pase a pdf

//@ Terminador del código
