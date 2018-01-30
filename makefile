#Ian Johnson -- 1-26-2018
#makefile meant to run lex on lab2remove.l and compile it to an executable
all: lab2remove.l
	flex lab2remove.l
	gcc -o lab2remove lex.yy.c
