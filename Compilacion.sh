lex Code-lex.l
gcc lex.yy.c -o prog -lfl
./prog $1 $2 $3
pdflatex -shell-escape $2
