## Copyright (C) 2015 Nicolás Jares
##
## Copying and distribution of this file, with or without modification,
## are permitted in any medium without royalty provided the copyright
## notice and this notice are preserved.  This file is offered as-is,
## without any warranty.

# Uso:
#
#	y=arista(i,j,A)
#
# Donde i y j deben ser enteros, y A debe ser una matriz de
# indices y valores de una matriz de incidencia de un grafo.
# Dados i y j nodos contiguos de un grafo dado por la matriz
# A, devulve un arreglo fila 'y', cuyo largo es igual a la
# cantidad de aristas de A, y que tiene un %*único*) 1 en la
# columna correspondiente a la arista que conecta i con j.
# 'y' %*está*) en formato sparse
#
function y=arista(i,j,A)
	A=sparse(A(:,1),A(:,2),A(:,3));
	i_1=find((A(:,i)-1)==0); % aristas que se inician en i
	i_2=find((A(:,j)+1)==0); % aristas que terminan en j
	y=sparse(1,intersect(i_1,i_2),1,1,rows(A));
endfunction
